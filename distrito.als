module distrito

one sig Distrito{
	pol_vet: set Pol_Veterano,
	pol_nov: set Pol_Novato,
	xerife: set Xerife,
	detetives: set Detetive
} 

abstract sig Policial{}

sig Pol_Veterano extends Policial{}
sig Pol_Novato extends Policial{}

sig Xerife{}

sig Detetive{}

abstract sig Chamada{
	pol_vet: set Pol_Veterano,
	pol_nov: set Pol_Novato,
	xer: set Xerife,
	det: some Detetive
}

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
	CodigoBranco
	CodigoVerde
	CodigoAzul
	CodigoVermelho
	TotalDePessoas
}

/**Predicados**/

pred CodigoBranco{
	all c:Cham_Branco |  #(c.pol_vet + c.pol_nov + c.xer) < 3
	all c:Cham_Branco | #(c.pol_vet + c.xer) != 0
	all c:Cham_Branco | #(c.det) = 0
}

pred CodigoVerde{
		all c:Cham_Verde |  #(c.pol_vet + c.pol_nov + c.xer) < 4
		all c:Cham_Verde |  #(c.pol_vet + c.pol_nov + c.xer) > 1
		all c:Cham_Verde |  #(c.pol_vet + c.xer) != 0
		all c:Cham_Verde | #(c.det) = 0
}

pred CodigoAzul{
		all c:Cham_Azul |  #(c.pol_vet + c.pol_nov + c.xer) = 4
		all c:Cham_Azul | #(c.det) = 0
}

pred CodigoVermelho{
		all c:Cham_Vermelho |  #(c.pol_vet + c.pol_nov + c.xer) = 4
		all c:Cham_Vermelho | #(c.det) = 1
}

pred TodoDistritoTemPoliciais{
	all d:Distrito | some d.pol_vet + d.pol_nov
}

pred TotalDePessoas{
	all c:Chamada, d:Distrito | #(c.pol_vet + d.pol_vet) = 3
	all c:Chamada, d:Distrito | #(c.pol_nov + d.pol_nov) = 3
	all c:Chamada, d:Distrito | #(c.det + d.detetives) = 2
	all c:Chamada, d:Distrito | #(c.xer + d.xerife) = 1
}
pred QtdeDePoliciaisNoDistrito{
	all d:Distrito | #(d.detetives) = 2
	all d:Distrito | #(d.pol_vet) = 3
	all d:Distrito | #(d.pol_nov) = 3
	all x:Xerife   | one d:Distrito | ! (x != d.xerife)
}

pred TodoPolicialEstaNoDistrito{
	all p:Pol_Veterano | one d:Distrito | p in d.pol_vet
    all p:Pol_Novato | one d:Distrito | p in d.pol_nov
	all det: Detetive | one d:Distrito | det in d.detetives
	all xer:Xerife | one d:Distrito | xer in d.xerife
}

pred TodoDetetiveEstaNoDistrito{ 
	all e:Detetive | one d:Distrito | e in d.detetives
}

/**Functions**/

/**Asserts**/
assert ExistePolicialNoDistrito{
	all dist:Distrito | #(dist.pol_vet + dist.pol_nov + dist.xerife + dist.detetives) != 0
}

assert TestaChamadaAzul{
	all c:Cham_Azul | #(c.pol_vet + c.pol_nov + c.xer) = 4
}

assert TestaChamadaVermelha{
	all c:Cham_Vermelho | #(c.pol_vet + c.pol_nov + c.xer + c.det) = 5
}

/**Checks**/
check ExistePolicialNoDistrito
check TestaChamadaAzul
check TestaChamadaVermelha

/**show**/
pred show[]{
}

run show for 7
