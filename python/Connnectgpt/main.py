# import google.generativeai as genai
# import time

# def get_gemini_response(prompt_text, retries=3, delay=5):
#     # Initialize the Gemini model
#     model = genai.GenerativeModel('gemini-1.5-pro-latest')
#     chat = model.start_chat(history=[])

#     # Prepare the context with the prompt
#     context = [f"Assyme you are a English Teacher : {prompt_text}"]

#     attempt = 0
#     while attempt < retries:
#         try:
#             # Send the prompt to Gemini AI
#             response = chat.send_message(context)

#             # Print the response to the command line
#             if response and response.text:
#                 print(f"Received response: {response.text}")
#                 return response.text
#             else:
#                 error_msg = "No response from AI"
#                 print(error_msg)
#                 return error_msg
#         except Exception as e:
#             # Print the exception to the command line
#             error_msg = str(e)
#             print(f"Exception occurred: {error_msg}")

#             # Retry mechanism
#             attempt += 1
#             if attempt < retries:
#                 print(f"Retrying in {delay} seconds...")
#                 time.sleep(delay)
#             else:
#                 return error_msg

# # Example usage
# prompt_text = "Create a 5 Grammer Question with Fillups i want in this method Question:questiion and Answer:answer and hint:hints"
# response = get_gemini_response(prompt_text)
# print('Evaluation Response:', response)



from flask import Flask, request, jsonify
import google.generativeai as genai
import time

app = Flask(__name__)

def get_gemini_response(prompt_text, retries=3, delay=5):
    model = genai.GenerativeModel('gemini-1.5-pro-latest')
    chat = model.start_chat(history=[])

    context = [f"Assume you are an English Teacher: {prompt_text}"]

    attempt = 0
    while attempt < retries:
        try:
            response = chat.send_message(context)

            if response and response.text:
                print(f"Received response: {response.text}") 
                return response.text 
            else:
                print("No response from AI")  
                return "No response from AI"
        except Exception as e:
            print(f"Error: {str(e)}")  
            attempt += 1
            if attempt < retries:
                time.sleep(delay)
            else:
                return f"Error: {str(e)}"

@app.route('/get_gemini_response', methods=['POST'])
def get_gemini_response_route():
    data = request.get_json()

    if 'prompt_text' not in data:
        return jsonify({"status": "error", "message": "prompt_text not provided"}), 400

    prompt_text = data['prompt_text']
    
    response = get_gemini_response(prompt_text)
    
    return jsonify({"response": response})

@app.route('/test_gemini', methods=['GET'])
def test_gemini():
    # Example prompt_text for testing
    prompt_text = "Create a 5 Grammar Question with Fillups. I want in this method Question: question, Answer: answer, and Hint: hints."
    
    response = get_gemini_response(prompt_text)
    
    return response


@app.route('/favicon.ico')
def favicon():
    return '', 204  

if __name__ == '__main__':
    app.run(debug=True)
        