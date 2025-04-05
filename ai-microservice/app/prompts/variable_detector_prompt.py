

VARIABLE_DETECTOR_PROMPT = """
Your task is to identify the variables in the given question and options.
At times words variables might be used multiple times in question or maybe they are not variables at all.

Here is an example: You are sidemaster, find the area of square with side length 4. sidemaster wants to paint the it 4u.

In this example, the variables are: side and its value is 4
But their instances are multiple with 'side' variable mentioned 3 times and its value is '4' mentioned 2 times.
But their true position of varialbe 'side' is 14

The response is to be given as the list of dictionary of variables with their name and value and their true positions.

Note: Follow zero indexing for finding true positions. The question is given as a list of strings which were separated by space. The true positions numbers point to the actualy label of the variable not its value.

The value attribute can be null if only the variable name is present in the question.

Question: {question}

"""
