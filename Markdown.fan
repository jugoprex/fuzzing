from faker import Faker
import random
#from utils import *

fake = Faker()
header_list = []
footnote_list = []
citation_list = []

def generateHeader(header_list):
    header, text = headerGenerator()
    reference = "[" + text.lower() + "]" + "(" + text.lower().replace(" ", "-") + ")"
    header_list.append(reference)
    return str(header) + ' ' + text + "\n"

def headerGenerator():
    return "#"*random.randint(1,4), fake.sentence().split('.')[0]

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

def citationGenerator(citation_list):
    number = citationNumber(citation_list)
    authors = [fake.last_name() for i in range(random.choice([2,3,4]))]
    tool = fake.word().capitalize()
    citation_list.append((number+1, authors,tool))
    return citationAuthor(citation_list) + " et al. introduced " + citationTool(citation_list) + ". [^" + str(number+1) + "]\n"


<start> ::= <text>
<text> ::= <negrita> | <italics> | <random_text> | "\n" <headers> | <link> | <table> | <referenceTable> | <formula> | <citation>
<random_text> ::= <printable>+ := fake.sentence()
<negrita> ::= "**" <random_text> "** "
<italics> ::= "_" <random_text> "_ "
<headers> ::=  <printable>+ := generateHeader(header_list)
<link> ::= "[" <random_text> "]" "(http:://www.hola.com)"

<table> ::= "| " <rowNumber> " | " <rowNumber> " | " <rowNumber> " | \n" "| -----------|---------------|------------ | \n" <row>+
<row> ::= "| " <rowNumber> " | " <rowNumber> " | " <rowNumber> " | \n"
<rowNumber> ::= <digit>+

<referenceTable> ::= "| References | \n" "| ------------------------------------ | \n" <referenceRow>+
<referenceRow> ::= "| " <footnote> " | \n"
<footnote> ::= <printable>* := footnoteGenerator(header_list)


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

<citation> ::= <citationText> <text>+ "\n\n" <citationFootnote> "\n\n"
<toolTitle> ::= <printable>* := citationTool(citation_list)
<citationText> ::= <printable>* := citationGenerator(citation_list)
<citationFootnote> ::= <printable>* := citationFootnoteGenerator(citation_list)

where len(<footnote>) > 0
where int(<rowNumber>) < 1000 
where int(<rowNumber>) > 10


