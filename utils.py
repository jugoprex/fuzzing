from faker import Faker
import random

fake = Faker()

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

def citationGenerator(citation_list):
    number = citationNumber(citation_list)
    authors = [fake.last_name() for i in range(4)]
    tool = fake.word().capitalize()
    citation_list.append((number+1, authors,tool))
    return citationAuthor(citation_list) + " et al. introduced " + citationTool(citation_list) + ". [^" + str(number+1) + "]"


#print(citationGenerator([]))