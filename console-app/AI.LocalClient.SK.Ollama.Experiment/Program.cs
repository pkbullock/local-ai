
using Microsoft.SemanticKernel;
using Microsoft.SemanticKernel.ChatCompletion;
using OllamaSharp;

IKernelBuilder builder = Kernel.CreateBuilder();


string ollamaEndpoint = "http://localhost:11434";
string ollamaModelId = "phi3.5:3.8b-mini-instruct-q4_0";

using var ollamaClient = new OllamaApiClient(
            uriString: ollamaEndpoint,
            defaultModel: ollamaModelId);

#pragma warning disable SKEXP0070 // Type is for evaluation purposes only and is subject to change or removal in future updates. Suppress this diagnostic to proceed.
builder.AddOllamaChatCompletion(ollamaClient);
#pragma warning restore SKEXP0070 // Type is for evaluation purposes only and is subject to change or removal in future updates. Suppress this diagnostic to proceed.

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
