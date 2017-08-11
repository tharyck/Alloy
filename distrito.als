module distrito

sig Distrito{
	policiais: set Policial,
	xerife: one Xerife,
	detetives: set Detetive
} 

abstract sig Policial{}

sig Pol_Veterano extends Policial{}
sig Pol_Novato extends Policial{}

sig Xerife{}

sig Detetive{}

abstract sig Chamada{}

sig Cham_Branco extends Chamada{}
sig Cham_Verde extends Chamada{}
sig Cham_Azul extends Chamada{}
sig Cham_Vermelho extends Chamada{}

/**fact**/
fact {
	TodoDistritoTemPoliciais
	QtdeDePoliciaisNoDistrito
	TodoPolicialEstaNoDistrito
	TodoDetetiveEstaNoDistrito
	#Distrito = 2
}

/**Predicados**/
pred TodoDistritoTemPoliciais{
	all d:Distrito | some d.policiais
}

pred QtdeDePoliciaisNoDistrito{
	all d:Distrito | #(d.detetives) = 2
	all d:Distrito | #(d.policiais) = 6
	all x:Xerife | one d:Distrito | ! (x != d.xerife)
}

pred TodoPolicialEstaNoDistrito{
	all p:Policial | one d:Distrito | p in d.policiais
}

pred TodoDetetiveEstaNoDistrito{ 
	all e:Detetive | one d:Distrito | e in d.detetives
}

/**show**/
pred show[]{
}

run show for 20
