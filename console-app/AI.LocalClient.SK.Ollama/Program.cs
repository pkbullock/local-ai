
using Microsoft.SemanticKernel.ChatCompletion;
using OllamaSharp;


string ollamaEndpoint = "http://localhost:11434";
string ollamaModelId = "phi3.5:3.8b-mini-instruct-q4_0";

using var ollamaClient = new OllamaApiClient(
            uriString: ollamaEndpoint,
            defaultModel: ollamaModelId);

#pragma warning disable SKEXP0001 // Type is for evaluation purposes only and is subject to change or removal in future updates. Suppress this diagnostic to proceed.
var chatService = ollamaClient.AsChatCompletionService();
#pragma warning restore SKEXP0001 // Type is for evaluation purposes only and is subject to change or removal in future updates. Suppress this diagnostic to proceed.

var history = new ChatHistory("You are a helpful assistant that knows about AI.");

// run chat
while (true)
{
    Console.Write("Q: ");
    var userQ = Console.ReadLine();
    if (string.IsNullOrEmpty(userQ))
    {
        break;
    }
    history.AddUserMessage(userQ);

    Console.Write($"Local: ");
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
