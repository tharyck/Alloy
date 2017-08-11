module distrito

sig Distrito{
	pol_vet: set Pol_Veterano,
	pol_nov: set Pol_Novato,
	xerife: one Xerife,
	detetives: set Detetive
} 

abstract sig Policial{}

sig Pol_Veterano extends Policial{}
sig Pol_Novato extends Policial{}

sig Xerife{}

sig Detetive{}

abstract sig Chamada{}

sig Cham_Branco extends Chamada{
	pol_vet: some Pol_Veterano,
	pol_nov: set Pol_Novato	
}
sig Cham_Verde extends Chamada{}
sig Cham_Azul extends Chamada{}
sig Cham_Vermelho extends Chamada{}

/**fact**/
fact {
	TodoDistritoTemPoliciais
	QtdeDePoliciaisNoDistrito
	TodoPolicialEstaNoDistrito
	TodoDetetiveEstaNoDistrito
	CodigoBranco
}

/**Predicados**/

pred CodigoBranco{
	all c:Cham_Branco |  #(c.pol_vet + c.pol_nov) < 3
}
pred TodoDistritoTemPoliciais{
	all d:Distrito | some d.pol_vet + d.pol_nov
}

pred QtdeDePoliciaisNoDistrito{
	all d:Distrito | #(d.detetives) = 2
	all d:Distrito | #(d.pol_vet) = 3
	all d:Distrito | #(d.pol_nov) = 3
	all x:Xerife | one d:Distrito | ! (x != d.xerife)
}

pred TodoPolicialEstaNoDistrito{
	all p:Pol_Veterano | one d:Distrito | p in d.pol_vet
    all p:Pol_Novato | one d:Distrito | p in d.pol_nov
}

pred TodoDetetiveEstaNoDistrito{ 
	all e:Detetive | one d:Distrito | e in d.detetives
}

/**show**/
pred show[]{
}

run show for 10
