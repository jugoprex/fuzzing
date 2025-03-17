from faker import Faker
fake = Faker()

<start> ::= <sentence>
<sentence> ::= <text>+
<text> ::= <complex_sentence> | <simple_sentence>
<complex_sentence> ::= <subject> " " <verb> " " <object> " " <connectors> " " <text>
<simple_sentence> ::= <subject> " " <verb> " " <object> ". "
<connectors> ::= "and" | "or" | "but" | ", " 
<subject> ::= <name> | <object>
<verb> ::= <word> := fake.verb()
<name> ::= <word> := fake.name()
<object> ::= <word> := fake.word()
<verb> ::= <word> := fake.word()
<word> ::= <printable>+ 