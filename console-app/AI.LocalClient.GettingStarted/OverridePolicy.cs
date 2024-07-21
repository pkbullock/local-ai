// OverridePolicy.cs
using Azure.Core.Pipeline;
using Azure.Core;
using System.ClientModel.Primitives;

internal partial class OverrideRequestUriPolicy(Uri overrideUri)
    : PipelinePolicy
{
    private readonly Uri _overrideUri = overrideUri;

    public override void Process(PipelineMessage message, IReadOnlyList<PipelinePolicy> pipeline, int currentIndex)
    {
        message.Request.Uri = _overrideUri;
    }

    public override ValueTask ProcessAsync(PipelineMessage message, IReadOnlyList<PipelinePolicy> pipeline, int currentIndex)
    {
        throw new NotImplementedException();
    }
}