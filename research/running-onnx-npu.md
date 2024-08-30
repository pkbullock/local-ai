# Research into running a Phi-3 model on an NPU

https://onnxruntime.ai/docs/execution-providers/QNN-ExecutionProvider.html

For ASP.NET there is a nuget package: 

- https://www.nuget.org/packages/Microsoft.ML.OnnxRuntime.QNN
- https://tomwildenhain-microsoft.github.io/onnxruntime/docs/get-started/with-csharp.html

Copilot generated code for running a model on an NPU:

```cmd
dotnet add package Microsoft.ML.OnnxRuntime
dotnet add package Microsoft.ML.OnnxRuntime.QNN
```

```csharp
using System;
using Microsoft.ML.OnnxRuntime;
using Microsoft.ML.OnnxRuntime.Tensors;

class Program
{
    static void Main(string[] args)
    {
        // Set up the session options to use the QNN Execution Provider
        var sessionOptions = new SessionOptions();
        sessionOptions.ExecutionMode = ExecutionMode.ORT_SEQUENTIAL;
        sessionOptions.GraphOptimizationLevel = GraphOptimizationLevel.ORT_ENABLE_ALL;

        // Specify the QNN Execution Provider
        sessionOptions.AppendExecutionProvider_QNN();

        // Load the ONNX model
        string modelPath = "path_to_your_model.onnx";
        using var session = new InferenceSession(modelPath, sessionOptions);

        // Prepare input data
        var inputName = session.InputMetadata.Keys.First();
        var inputData = new DenseTensor<float>(new float[] { /* your input data here */ }, new int[] { 1, 3, 224, 224 });

        // Run the model
        var inputs = new List<NamedOnnxValue> { NamedOnnxValue.CreateFromTensor(inputName, inputData) };
        using var results = session.Run(inputs);

        // Process the outputs
        foreach (var result in results)
        {
            Console.WriteLine($"{result.Name}: {result.AsTensor<float>().GetArrayString()}");
        }
    }
}
```
