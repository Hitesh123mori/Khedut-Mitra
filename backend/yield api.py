# from flask import Flask, request, jsonify
# import pickle
# import numpy as np

# # Load the model and preprocessor
# with open('ml models\yield prediction model.pkl', 'rb') as model_file:
#     model = pickle.load(model_file)

# with open('ml models\preprocessor.pkl', 'rb') as preprocessor_file:
#     preprocessor = pickle.load(preprocessor_file)

# # Create the Flask app
# app = Flask(__name__)

# @app.route('/predict_yield', methods=['GET'])
# def predict():
#     try:
#         # Get JSON data from request
#         # data = request.get_json()

#         # Extract values from the JSON data
#         Year = 2024
#         Item = request.args.get('item')
#         average_rain_fall_mm_per_year = 1485.0
#         pesticides_tonnes = 121.00
#         avg_temp = 16.37
#         Area = 'India'

#         # Create an array of the input features
#         features = np.array([[Year, average_rain_fall_mm_per_year, pesticides_tonnes, avg_temp, Area, Item]], dtype=object)
#         # Transform the features using the preprocessor
#         transformed_features = preprocessor.transform(features)

#         # Make the prediction
#         predicted_yield = model.predict(transformed_features).reshape(1, -1)

#         print(predicted_yield)
#         # Return the prediction as JSON, unit: quintal/hectare
#         return jsonify({'prediction': (predicted_yield[0][0])})
    
#     except Exception as e:
#         return jsonify({'error': str(e)}), 400

# if __name__ == '__main__':
#     app.run(debug=True)
import gradio as gr
import pickle
import numpy as np

# Load the model and preprocessor
with open('ml models/yield prediction model.pkl', 'rb') as model_file:
    model = pickle.load(model_file)

with open('ml models/preprocessor.pkl', 'rb') as preprocessor_file:
    preprocessor = pickle.load(preprocessor_file)

# Define the prediction function
def predict_yield(Item, Year=2024, average_rain_fall_mm_per_year=1485.0, pesticides_tonnes=121.0, avg_temp=16.37, Area='India'):
    try:
        # Create an array of the input features
        features = np.array([[Year, average_rain_fall_mm_per_year, pesticides_tonnes, avg_temp, Area, Item]], dtype=object)
        # Transform the features using the preprocessor
        transformed_features = preprocessor.transform(features)

        # Make the prediction
        predicted_yield = model.predict(transformed_features).reshape(1, -1)

        # Return the prediction as a string
        return f"Predicted Yield: {predicted_yield[0][0]:.2f} quintals/hectare"
    
    except Exception as e:
        return str(e)

# Create the Gradio interface
iface = gr.Interface(
    fn=predict_yield,
    inputs=[
        gr.Textbox( label="Item"),
        gr.Number(label="Year"),
        gr.Number(label="Average Rainfall (mm/year)"),
        gr.Number( label="Pesticides Used (tonnes)"),
        gr.Number( label="Average Temperature (°C)"),
        gr.Textbox(label="Area")
    ],
    outputs="text",
    title="Crop Yield Prediction",
    description="Enter the details to predict the crop yield (in quintals/hectare)."
)

# Launch the Gradio interface
if __name__ == '__main__':
    iface.launch()
