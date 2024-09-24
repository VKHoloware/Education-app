# from flask import Flask, request, jsonify
# import google.generativeai as genai

# # Initialize Flask application
# app = Flask(__name__)

# # Configure API key for Google Gemini
# genai.configure(api_key='AIzaSyAuUiXOdpn9ORAh98NGVaekMr105sACWI8')

# # Initialize the Gemini Generative Model
# model = genai.GenerativeModel('gemini-1.5-pro-latest')

# @app.route('/generate', methods=['GET'])
# def generate_response():
#     # Get the context from the query parameters
#     context = request.args.get('context', 'Tell a Story ')

#     # Start a chat session with the model
#     chat = model.start_chat(history=[])

#     # Send the message to Gemini and get the response
#     response = chat.send_message(context)

#     # Return the response as plain text
#     return response.text
# @app.route('/generatesynonyms', methods=['GET'])
# def generate_synonyms():
#     # Get the context from the query parameters
#     context = request.args.get('context', 'Genrate the Synonyms ')

#     # Start a chat session with the model
#     chat = model.start_chat(history=[])

#     # Send the message to Gemini and get the response
#     response = chat.send_message(context)

#     # Return the response as plain text
#     return response.text

# @app.route('/test_gemini', methods=['GET'])
# def test_gemini():
#     # context = request.args.get('context', 'Create a 5 Synonyms Question with Fillups. I want in this method Question: question, Answer: answer: hints with no any another special character i want the exact format only question:question answer:answerin a json format question:question ,answer:answer exact ormat not a single word extra.')

#     # # Start a chat session with the model
#     # chat = model.start_chat(history=[])

#     # # Send the message to Gemini and get the response
#     # response = chat.send_message(context)

#     # # Return the response as plain text
#     # return response.text
#        context = request.args.get('context', 'Create a 5 Synonyms Question with Fillups. I want in this method Question: question, Answer: answer: hints with no any another special character i want the exact format only question:question answer:answerin a json format question:question ,answer:answer exact ormat not a single word extra.')
#     chat = model.start_chat(history=[])
#     response = chat.send_message(context)

#     # Assuming response.text is in some dynamic format
#     raw_text = response.text

#     # Example of parsing the response - this will vary based on actual format
#     # For demonstration, let's assume raw_text is a string in a format like:
#     # "question: Mellifluous is most similar in meaning to which word? choices: [Discordant, Harmonious, Cacophonous, Strident, Raucous] answer: Harmonious"

#     # Split the response into parts
#     parts = raw_text.split("choices: ")
#     question_part = parts[0].split("question: ")[1]
#     answer_part = parts[1].split("answer: ")[1]
    
#     choices_text = parts[1].split("answer: ")[0].strip("[] ")
#     choices = [choice.strip() for choice in choices_text.split(",")]

#     # Create the structured response
#     formatted_response = {
#         "question": question_part.strip(),
#         "choices": choices,
#         "answer": answer_part.strip()
#     }

#     return jsonify(formatted_response)

# # Run the Flask application
# if __name__ == '__main__':
#     app.run(debug=True)

from flask import Flask, request, jsonify
import google.generativeai as genai

# Initialize Flask application
app = Flask(__name__)

# Configure API key for Google Gemini
genai.configure(api_key='AIzaSyAuUiXOdpn9ORAh98NGVaekMr105sACWI8')

# Initialize the Gemini Generative Model
model = genai.GenerativeModel('gemini-1.5-pro-latest')

@app.route('/generate', methods=['GET'])
def generate_response():
    context = request.args.get('context', 'Tell a Story')
    chat = model.start_chat(history=[])
    response = chat.send_message(context)
    return response.text

@app.route('/generatesynonyms', methods=['GET'])
def generate_synonyms():
    context = request.args.get('context', 'Generate the Synonyms')
    chat = model.start_chat(history=[])
    response = chat.send_message(context)
    return response.text

@app.route('/test_gemini', methods=['GET'])
def test_gemini():
    context = request.args.get('context', 'Create a 5 Synonyms Question with Fillups. I want in this method Question: question, Answer: answer: hints with no any another special character i want the exact format only question:question answer:answer in a json format question:question ,answer:answer exact format not a single word extra if question end it will show the question mark symbol comulsary.')
    
    chat = model.start_chat(history=[])
    response = chat.send_message(context)
    
    # Assuming response.text is in some dynamic format
    raw_text = response.text
    
    try:
        # Example parsing: assuming response contains "question: question_text choices: [choice1, choice2, choice3, choice4] answer: correct_answer"
        question_start = raw_text.find("question: ")
        question_end = raw_text.find(".")
        question = raw_text[question_start + len("question: "):question_end].strip()
        
        choices_start = raw_text.find("choices: [")
        choices_end = raw_text.find("] answer: ")
        choices_text = raw_text[choices_start + len("choices: ["):choices_end].strip()
        choices = [choice.strip() for choice in choices_text.split(",")]

        answer_start = raw_text.find("answer: ")
        answer = raw_text[answer_start + len("answer: "):].strip()
        print(question)
        print(choices)
        print(answer)
        
        
        formatted_response = {
            "question": question,
            "choices": choices,
            "answer": answer
        }
        
        return jsonify(formatted_response)
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Run the Flask application
if __name__ == '__main__':
    app.run(debug=True)
