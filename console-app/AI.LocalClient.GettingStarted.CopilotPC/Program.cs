// Program.cs
using Microsoft.ML.OnnxRuntimeGenAI;
using Microsoft.ML.OnnxRuntime;
using System.Reflection.Emit;
using System.Reflection;

/*
 *  This sample rather than uses AI Toolkit (AITK) to interact with the Phi3 model. Interacts with the Phi3 model directly.
 *  Allowing for flexibility and reduced dependencies on future learning.
 *  
 *  This is based on the Phi3 model from Microsoft. The Phi3 model is a mini model that is designed to be used on a CPU or mobile device.
 *  Original Sample: https://github.com/microsoft/Phi-3CookBook from Labs.
 *  
 */
var modelPath = Path.Join(Environment.GetFolderPath(Environment.SpecialFolder.UserProfile),
        @"\.aitk\models\microsoft\Phi-3-mini-4k-instruct-onnx\cpu_and_mobile\cpu-int4-rtn-block-32-acc-level-4");

var model = new Model(modelPath);
var tokenizer = new Tokenizer(model);

var systemPrompt = "You are an AI assistant that helps people find information. Answer questions using a direct style. Do not share more information that the requested by the users.";

// chat start
Console.WriteLine(@"Ask your question. Type an empty string to Exit.");

// chat loop
while (true)
{
    // Get user question
    Console.WriteLine();
    Console.Write(@"Q: ");
    var userQ = Console.ReadLine();
    if (string.IsNullOrEmpty(userQ))
    {
        break;
    }

    // show phi3 response
    Console.Write("Phi3: ");
    var fullPrompt = $"<|system|>{systemPrompt}<|end|><|user|>{userQ}<|end|><|assistant|>";
    var tokens = tokenizer.Encode(fullPrompt);

    var generatorParams = new GeneratorParams(model);
    generatorParams.SetSearchOption("max_length", 2048);
    generatorParams.SetSearchOption("past_present_share_buffer", false);
    generatorParams.SetInputSequences(tokens); 

    var generator = new Generator(model, generatorParams);
    while (!generator.IsDone())
    {
        generator.ComputeLogits();
        generator.GenerateNextToken();
        ReadOnlySpan<int> outputTokens = generator.GetSequence(0);
        ReadOnlySpan<int> newToken = outputTokens.Slice(outputTokens.Length - 1, 1);
        var output = tokenizer.Decode(newToken);
        Console.Write(output);
    }
    Console.WriteLine();
}
