import onnx
import onnxruntime as ort
import numpy as np
from PIL import Image
import sys

def preprocess_image(image_path):
    # Load image
    image = Image.open(image_path).convert('RGB')  # Convert to grayscale
    image = image.resize((128, 128))  # Resize to the required input size
    image_data = np.array(image).astype(np.uint8)
    image_data = image_data.transpose(2, 0, 1)  # Change data layout from HWC to CHW
    image_data = np.expand_dims(image_data, axis=0)  # Add batch dimension
    return image_data

def postprocess_output(output_data):
    # Remove batch dimension and change data layout from CHW to HWC
    output_image = output_data.squeeze().transpose(1, 2, 0)
    # Convert to uint8
    output_image = output_image.astype(np.uint8)
    return output_image

def main(image_path):
    # Check available providers
    available_providers = ort.get_available_providers()
    print("Available providers:", available_providers)

    # Load the ONNX model
    model_path = r"C:\\ai\\models\\quicksrnetlarge_quantized.onnx"  # Ensure this file exists in the correct path
    
    # Use QNNExecutionProvider if available, otherwise fall back to CPUExecutionProvider
    if 'QNNExecutionProvider' in available_providers:
        providers = ['QNNExecutionProvider']
    else:
        providers = ['CPUExecutionProvider']
        print("Warning: QNNExecutionProvider not available, using CPUExecutionProvider")

    ort_session = ort.InferenceSession(model_path, providers=providers)

    # Prepare input data
    input_name = ort_session.get_inputs()[0].name
    input_data = preprocess_image(image_path)

    # Run the model
    result = ort_session.run(None, {input_name: input_data})

    # Post-process the output
    output_image = postprocess_output(result[0])

    # Save the output image
    output_image = Image.fromarray(output_image)
    output_image.save("output_image.png")
    print("Output image saved as output_image.png")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <path_to_image>")
    else:
        main(sys.argv[1])
