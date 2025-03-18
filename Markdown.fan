from faker import Faker
from google import genai

import random
#from utils import *

fake = Faker()
header_list = []
footnote_list = []
citation_list = []
one_list = []

def generateHeader(header_list):
    header, text = headerGenerator()
    reference = "[" + text.lower() + "]" + "(" + text.lower().replace(" ", "-") + ")"
    header_list.append(reference)
    if len(reference) % 2 == 0:
        return str(header) + ' ' + text + "\n"
    return ''

def headerGenerator():
    sentence = fake.sentence().split('.')[0]

    words = sentence.split()

    random_word = random_scientific_word()

    index_to_replace = random.randint(0, len(words) - 1)

    words[index_to_replace] = random_word

    new_sentence = ' '.join(words)
    return "#"*random.randint(1,4), new_sentence

def footnoteGenerator(header_list):
    if header_list:
        return str(random.choice(header_list))
    return ''


def citationNumber(citation_list):
    if citation_list:
        number, a, b = citation_list[-1]
        return number
    return 0

def citationAuthor(citation_list):
    if citation_list:
        a, authors, b = citation_list[-1]
        return authors[0]
    return ''

def citationAuthors(citation_list):
    if citation_list:
        a, authors, b = citation_list[-1]
        return ', '.join(authors)
    return ''

def citationTool(citation_list):
    if citation_list:
        a, b, tool = citation_list[-1]
        return tool
    return ''

def citationFootnoteGenerator(citation_list):
    number = citationNumber(citation_list)
    authors = citationAuthors(citation_list)
    tool = citationTool(citation_list)
    year = fake.year()
    return "[^" + str(number) + "]: " + authors + ": " + tool + ", " + str(year) + ". "

def authorsNameGenerator():
    return [fake.name() for i in range(random.choice([2,3,4]))]

def authorsLastNameGenerator():
    return [fake.last_name() for i in range(random.choice([2,3,4]))]

def citationGenerator(citation_list):
    number = citationNumber(citation_list)
    authors = authorsLastNameGenerator()
    tool = fake.word().capitalize()
    citation_list.append((number+1, authors,tool))
    return citationAuthor(citation_list) + " et al. introduced " + citationTool(citation_list) + ". [^" + str(number+1) + "]\n"

#Bonus
def geminiResponse(prompt):
    client = genai.Client(api_key="AIzaSyCkxOu7PLX-rQE8aJdjsV7nqZIK-3N5TJs")
    response = client.models.generate_content(
        model="gemini-2.0-flash",
        contents="Write a scientific abstract of this title (without abstract subtitle) in 60 words: " + prompt,
    )
    return response.text

#First part of the paper
def generateOne(one_list):
    if not one_list:
        fake_sentence = fake.sentence()
        one_list.append(fake_sentence)
        authors = authorsNameGenerator()
        response = geminiResponse(fake_sentence)
        title = "<h1 style=\"text-align: center;\"> " + fake_sentence + " </h1>"
        authors = "\n " + ", ".join(authors) + "\n"
        abstract = "<h2> Abstract </h2> \n" + response + "\n\n"
        introduction_header = generateHeader([])
        return title + authors + abstract + introduction_header
    return ''

def random_scientific_word():
    words = [
        "algorithm", "bitwise", "cache", "computability", "data structure",
        "encryption", "fractal", "graph theory", "hashing", "iteration",
        "jitter", "kernel", "latency", "machine learning", "neural network",
        "optimization", "polynomial", "quantum computing", "recursion", "symmetry",
        "topology", "vectorization", "wavelet", "xor", "asymptotic",
        "bayesian", "complexity", "differentiation", "entropy",
        "fourier transform", "gradient descent", "homomorphism", "induction", "jacobian",
        "kolmogorov complexity", "lambda calculus", "monte carlo", "normalization", "p vs np",
        "quicksort", "randomization", "sparse matrix", "trigonometry", "undirected graph",
        "voronoi diagram", "zero-knowledge proof", "big-o notation", "zeta function",
        "boolean algebra", "turing machine", "hilbert space", "linear regression",
        "singular value decomposition", "combinatorics", "dijkstra's algorithm", "pagerank",
        "convex hull", "bayes' theorem", "state machine", "entropy coding",
        "finite automaton", "stochastic process", "laplace transform", "decision tree",
        "graph isomorphism", "binary search", "markov chain", "newton's method",
        "support vector machine", "probabilistic model", "logarithmic scale",
        "hyperbolic function", "eigenvalue decomposition", "cryptographic hash",
        "recursive function", "fibonacci sequence", "taylor series", "vector space",
        "bernoulli distribution", "gaussian elimination", "least squares",
        "wave-particle duality", "hilbert transform",

        "apple", "banana", "table", "chair", "window",
        "door", "mountain", "river", "ocean", "forest",
        "moon", "sun", "star", "planet", "cloud",
        "flower", "tree", "book", "pencil", "paper",
        "school", "university", "car", "train", "airplane",
        "computer", "keyboard", "mouse", "screen", "phone",
        "backpack", "wallet", "money", "clock", "watch",
        "bottle", "cup", "glass", "plate", "spoon",
        "fork", "knife", "bed", "pillow", "blanket",
        "city", "village", "country", "continent", "bridge"
    ]
    return random.choice(words)

def random_connector():
    connectors = [
        "and", "also", "moreover", "furthermore", "in addition", "besides", "not only that",
        "but", "however", "nevertheless", "on the other hand", "whereas", "while", "although", "even though",
        "because", "since", "as", "due to", "therefore", "thus", "consequently", "as a result",
        "similarly", "likewise", "just like", "in the same way",
        "if", "unless", "provided that", "as long as",
        "before", "after", "then", "next", "meanwhile", "subsequently", "eventually",
        "in conclusion", "to sum up", "in summary", "all in all", "ultimately"
    ]
    return random.choice(connectors)

<start> ::= <introduction> <text>
<text> ::= <random_text> | "\n" <headers> | <table> | <referenceTable> | <formula>
<introduction> ::= <printable>* := generateOne(one_list)
<random_text> ::= <sentence>+
<headers> ::=  <printable>+ := generateHeader(header_list)


#Task 3
<sentence> ::= "  " <texting> <texting> <texting> <texting> <texting> <texting> <texting> <texting>
<texting> ::= <complex_sentence> | <simple_sentence>
<complex_sentence> ::= <subject> " " <verb> " " <object> " " <connectors> " " <texting>
<simple_sentence> ::= <subject> " " <verb> " " <object> <punctuation_marks>
<punctuation_marks> ::=  ", " | ". " | "! "
<connectors> ::= <word> := random_connector()
<subject> ::= <name> | <object>
<verb> ::= <word> := fake.verb()
<name> ::= <word> := fake.name()
<object> ::= <random_object> | <random_cientific_object> | <negrita> | <italics> | <link> | <citation>
<negrita> ::= "**" <random_cientific_object> "** "
<italics> ::= "_" <random_cientific_object> "_ "
<link> ::= "[" <random_cientific_object> "]" "(http:://www.hola.com)"
<random_object> ::= <word> := fake.word()
<random_cientific_object> ::= <word> := random_scientific_word()
<verb> ::= <word> := fake.word()
<word> ::= <printable>+ 

#Task 4
<table> ::= "| " <rowNumber> " | " <rowNumber> " | " <rowNumber> " | \n" "| -----------|---------------|------------ | \n" <row>+
<row> ::= "| " <rowNumber> " | " <rowNumber> " | " <rowNumber> " | \n"
<rowNumber> ::= <digit>+

<referenceTable> ::= "| References | \n" "| ------------------------------------ | \n" <referenceRow>+
<referenceRow> ::= "| " <footnote> " | \n"
<footnote> ::= <printable>* := footnoteGenerator(header_list)

#Task 7
<formula> ::= "$$" <math> "$$\n"
<math> ::= <equation> | <expression>
<equation> ::= <expression> "=" <expression> | <expression> "<" <expression> | <expression> ">" <expression> | <expression> "<=" <expression> | <expression> ">=" <expression>
<expression> ::= <term> | <term> "+" <expression> | <term> "-" <expression>
<term> ::= <factor> | <factor> "*" <term> | <factor> "/" <term> | <sum> | <frac> | <factor> "^" <factor> | <integral>
<integral> ::= "\int_{"<variable>" = "<number>"}^{"<number>"} "<expression>
<factor> ::= <number> | <variable> | "(" <expression> ")"
<sum> ::= "\sum_{"<variable>" = "<number>"}^{"<number>"} "<expression>
<frac> ::= "\\frac{"<expression>"}{"<expression>"}"
<number> ::= <digit>+
<variable> ::= "x" | "y" | "z"

#Task 8
<citation> ::= <citationText> <text>+ "\n\n" <citationFootnote> "\n\n"
<citationText> ::= <printable>* := citationGenerator(citation_list)
<citationFootnote> ::= <printable>* := citationFootnoteGenerator(citation_list)

#Task 5
where len(<footnote>) > 0
where int(<rowNumber>) < 1000 
where int(<rowNumber>) > 10


