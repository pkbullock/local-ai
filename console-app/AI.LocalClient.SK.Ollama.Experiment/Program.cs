
using Microsoft.Extensions.AI;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.SemanticKernel;
using Microsoft.SemanticKernel.ChatCompletion;
using OllamaSharp;
using OpenTelemetry;
using OpenTelemetry.Logs;
using OpenTelemetry.Metrics;
using OpenTelemetry.Resources;
using OpenTelemetry.Trace;

internal class Program
{
    private static async Task Main(string[] args)
    {
        IKernelBuilder builder = Kernel.CreateBuilder();

        #region TelemetryWithAspire

        // Reference: https://learn.microsoft.com/en-us/semantic-kernel/concepts/enterprise-readiness/observability/telemetry-with-aspire-dashboard?tabs=Powershell&pivots=programming-language-csharp#add-telemetry

        // Endpoint to the Aspire Dashboard
        var aspireEndpoint = "https://localhost:21223"; //"http://localhost:19176"; //https://localhost:21223";

        var resourceBuilder = ResourceBuilder
            .CreateDefault()
            .AddService("AI.LocalClient.SK.Ollama.Experiment");

        // Enable model diagnostics with sensitive data.
        AppContext.SetSwitch("Microsoft.SemanticKernel.Experimental.GenAI.EnableOTelDiagnosticsSensitive", true);

        using var traceProvider = Sdk.CreateTracerProviderBuilder()
            .SetResourceBuilder(resourceBuilder)
            .AddSource("Microsoft.SemanticKernel*")
            .AddSource("OllamaSharp*")
            //.AddConsoleExporter()
            .AddOtlpExporter(options => {
                options.Endpoint = new Uri(aspireEndpoint);
                options.Protocol = OpenTelemetry.Exporter.OtlpExportProtocol.Grpc;
             })
            .Build();

        using var meterProvider = Sdk.CreateMeterProviderBuilder()
            .SetResourceBuilder(resourceBuilder)
            .AddMeter("Microsoft.SemanticKernel*")
            .AddMeter("OllamaSharp*")
            //.AddConsoleExporter()
            .AddOtlpExporter(options => {
                options.Endpoint = new Uri(aspireEndpoint);
                options.Protocol = OpenTelemetry.Exporter.OtlpExportProtocol.Grpc;
            })
            .Build();

        using var loggerFactory = LoggerFactory.Create(builder =>
        {
            // Add OpenTelemetry as a logging provider
            builder.AddOpenTelemetry(options =>
            {
                options.SetResourceBuilder(resourceBuilder);
                //options.AddConsoleExporter();
                options.AddOtlpExporter(options => {
                    options.Endpoint = new Uri(aspireEndpoint);
                    options.Protocol = OpenTelemetry.Exporter.OtlpExportProtocol.Grpc;
                });
                // Format log messages. This is default to false.
                options.IncludeFormattedMessage = true;
                options.IncludeScopes = true;
            });
            builder.SetMinimumLevel(LogLevel.Trace);
        });

        builder.Services.AddSingleton(loggerFactory);

        #endregion

        string ollamaEndpoint = "http://localhost:11434";
        string ollamaModelId = "phi3.5:3.8b-mini-instruct-q4_0";

        using var ollamaClient = new OllamaApiClient(
                    uriString: ollamaEndpoint,
                    defaultModel: ollamaModelId);

#pragma warning disable SKEXP0070 // Type is for evaluation purposes only and is subject to change or removal in future updates. Suppress this diagnostic to proceed.
        builder.AddOllamaChatCompletion(ollamaClient);
#pragma warning restore SKEXP0070 // Type is for evaluation purposes only and is subject to change or removal in future updates. Suppress this diagnostic to proceed.

        builder.Services.AddChatClient(b => b.GetRequiredService<IChatClient>())
                .UseFunctionInvocation()
                .UseOpenTelemetry(configure: t => t.EnableSensitiveData = true, loggerFactory: loggerFactory)
                .UseLogging();


        var kernel = builder.Build();

        var history = new ChatHistory("You are a helpful assistant that knows about AI.");

        var chatService = kernel.GetRequiredService<IChatCompletionService>();

        // run chat
        while (true)
        {
            Console.Write("You: ");
            var userQuery = Console.ReadLine();
            if (string.IsNullOrEmpty(userQuery))
            {
                break;
            }
            history.AddUserMessage(userQuery);

            Console.Write($"LocalAI: ");
            var response = "";
            var result = chatService.GetStreamingChatMessageContentsAsync(history);
            await foreach (var message in result)
            {
                Console.Write(message.Content);
                response += message.Content;
            }
            history.AddAssistantMessage(response);
            Console.WriteLine("");
        }
    }
}