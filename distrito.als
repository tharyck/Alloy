module distrito

sig Distrito{
	policiais: set Policial
} 

abstract sig Policial{}

sig Pol_Veterano extends Policial{}
sig Pol_Novato extends Policial{}

one sig Xerife{}

sig Detetive{}

abstract sig Chamada{}

sig Cham_Branco extends Chamada{}
sig Cham_Verde extends Chamada{}
sig Cham_Azul extends Chamada{}
sig Cham_Vermelho extends Chamada{}

fact {
	all d:Distrito | some d.policiais
	#Detetive = 2
	all p:Policial | one p.~policiais
	#Pol_Veterano = 3
	#Pol_Novato = 3
}

pred show[]{
}

run show for 6
