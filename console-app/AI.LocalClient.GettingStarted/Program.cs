// Program.cs
using OpenAI;
using OpenAI.Chat;
using System.ClientModel;
using System.ClientModel.Primitives;

internal class Program
{
    private static async Task Main(string[] args)
    {
        Uri localhostUri = new("http://localhost:5272/v1/chat/completions");

        //AzureOpenAIClientOptions clientOptions = new OpenAIClientOptions
        //{
        //    Endpoint = localhostUri
        //};

        OpenAIClientOptions clientOptions = new();

        clientOptions.AddPolicy(
            new OverrideRequestUriPolicy(localhostUri), PipelinePosition.BeforeTransport);

        OpenAIClient client = new(new System.ClientModel.ApiKeyCredential("unused"),
            clientOptions);

        ChatClient chatClient = client.GetChatClient("Phi-3-mini-4k-directml-int4-awq-block-128-onnx");


        ResultCollection<StreamingChatCompletionUpdate> completionUpdates =
            chatClient.CompleteChatStreaming(
            [
                new SystemChatMessage("You are a helpful assistant. Be brief and succinct."),
                new UserChatMessage("What is the golden ratio?"),
            ]);

        foreach (StreamingChatCompletionUpdate completionUpdate in completionUpdates)
        {
            foreach (ChatMessageContentPart contentPart in completionUpdate.ContentUpdate)
            {
                Console.Write(contentPart.Text);
            }
        }
    }
}