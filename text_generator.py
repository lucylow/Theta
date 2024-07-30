import openai
import re
from api_key import API_KEY

openai.api_key = API_KEY

# Set the model to use
model_engine = "text-davinci-003"

# Set the prompt to generate text for the AI writer's room
text = input("What story do you want to write about: ")
prompt = text

print("The AI writer's room is trying now to generate a new text for you...")
# Generate text using the GPT-3 model
completions = openai.Completion.create(
    engine=model_engine,
    prompt=prompt,
    max_tokens=1024,
    n=1,
    stop=None,
    temperature=0.5,
)

# Print the generated text
generated_text = completions.choices[0].text

# Save the text in a file
with open("generated_text.txt", "w") as file:
    file.write(generated_text.strip())

print("The Text Has Been Generated Successfully!")
