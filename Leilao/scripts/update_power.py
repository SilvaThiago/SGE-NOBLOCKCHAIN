#!/usr/bin/python

import mysql.connector
import time

mydb = mysql.connector.connect(
  host="localhost",
  user="auctions",
  password="Thiago23071992!",
  database="leilao"
)


# getting power from simulink file
PATH_PDC = "/home/thiago/Documentos/Coding/Truffle/auctions-no-blockchain/scripts/PDCmean.in"

PDCfile = open(PATH_PDC, "r")

lines = PDCfile.readlines()

PDCfile.close()


while True :
	# getting info about houses from db
	mycursor = mydb.cursor()

	sql = "SELECT * FROM leilao.tb_casa;"

	mycursor.execute(sql)

	myresult = mycursor.fetchall()

	resultsize = len(myresult)


	for x in myresult:
		currentID = x[0]
		sql = "SELECT saldo_energetico FROM leilao.tb_casa WHERE id=" + str(currentID)
		mycursor.execute(sql)
		currentHouse = mycursor.fetchall()

		# (10 x quantidade de placas * producao) + salto atual 
		newSaldo = (10 * x[3] * float(lines[0])) + currentHouse[0][0]

		sql = "UPDATE leilao.tb_casa SET saldo_energetico=" + str(newSaldo) + " WHERE id=" + str(x[0])
		mycursor.execute(sql)
		mydb.commit()

		del lines[0]

	print ("Aguardando 1 min")
	time.sleep(60)
	print ("Tempo finalizado")


new_PDCfile = open(PATH_PDC, "w+")

for line in lines:
	new_PDCfile.write(line)

new_PDCfile.close()
