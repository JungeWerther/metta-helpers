from hyperon import MeTTa

metta = MeTTa()
res = metta.run('''
(Parent Tom Bob)
(Parent Bob Joe)
(Parent Liz Bob)
(Parent Joe Bob)
                !(match &self (Parent $x Bob) $x)
                !(match &self (Parent Bob $x) $x)
''')

print(res)