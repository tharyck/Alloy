module distrito

one sig Distrito{
	pol_vet: set Pol_Veterano,
	pol_nov: set Pol_Novato,
	xerife: set Xerife,
	detetives: set Detetive,
	chamadas: set Chamada
} 

abstract sig Policial{}

sig Pol_Veterano extends Policial{}
sig Pol_Novato extends Policial{}

sig Xerife{}

sig Detetive{}

abstract sig Chamada{
	pol_vt: set Pol_Veterano,
	pol_nv: set Pol_Novato,
	xer: set Xerife,
	det: set Detetive
}

sig Cham_Branco extends Chamada{}

sig Cham_Verde extends Chamada{}

sig Cham_Azul extends Chamada{}

sig Cham_Vermelho extends Chamada{}

/**fact**/
fact {
	PresencaDePoliciais 	//Todo policial está em um distrito
	QtdeDePoliciais		   //Quantidade de Policiais no distrito
	PoliciaisChamadas	
	ChamadasParaDistrito //Todo chamada é endereçada a um distrito
	ChamadasPoliciais
	CodigoBranco
	CodigoVerde
	CodigoAzul
	CodigoVermelho
}


/**Predicados**/
pred PresencaDePoliciais {
	//Todo policial está em um distrito
	all pol_v: Pol_Veterano | one pol_v.~pol_vet
	all pol_n: Pol_Novato | one pol_n.~pol_nov
	all dt: Detetive | one dt.~detetives
	all xf: Xerife | one xf.~xerife
}

pred QtdeDePoliciais{
	//Quantidade de Policiais no distrito
	all d:Distrito | #(d.detetives) = 2
	all d:Distrito | #(d.pol_vet) = 3
	all d:Distrito | #(d.pol_nov) = 3
	all d:Distrito | # (d.xerife) = 1
}

pred ChamadasParaDistrito{
	//Todo chamada é endereçada a um distrito
	all c:Chamada | one c.~chamadas
}

pred PoliciaisChamadas {
	all c:Chamada, d:Distrito | (c.pol_vt) in (d.pol_vet)
	all c:Chamada, d:Distrito | (c.pol_nv) in (d.pol_nov)
	all c:Chamada, d:Distrito | (c.det) in (d.detetives)
	all c:Chamada, d:Distrito | (c.xer) in (d.xerife)
}

pred ChamadasPoliciais{
	all p:Pol_Veterano |  #(p.~pol_vt) = 1
	all p:Pol_Novato |  #(p.~pol_nv) = 1
	all d:Detetive |   #(d.~det) >= 0
	all x:Xerife |  #(x.~xer) = 1
}

//Codigos
pred CodigoBranco{ 
	all c:Cham_Branco | #(c.pol_vt + c.pol_nv + c.xer) < 3
	all c:Cham_Branco | #(c.pol_vt + c.xer) > 0
	all c:Cham_Branco | #(c.det) = 0
}

pred CodigoVerde{
	all c:Cham_Verde | #(c.pol_vt + c.pol_nv + c.xer) > 1 
	all c:Cham_Verde | #(c.pol_vt + c.pol_nv + c.xer) < 4
	all c:Cham_Verde | #(c.pol_vt + c.xer) > 0
	all c:Cham_Verde | #(c.det) = 0
}

pred CodigoAzul{
	all c:Cham_Azul | #(c.pol_vt + c.pol_nv + c.xer) = 4
	all c:Cham_Azul | #(c.pol_vt + c.xer) > 0
	all c:Cham_Azul | #(c.det) = 0
}

pred CodigoVermelho{
	all c:Cham_Vermelho | #(c.det) = 1 && #(c.pol_vt + c.pol_nv + c.xer) = 4
	all c:Cham_Vermelho | #(c.pol_vt + c.xer) > 0
}


/**Asserts**/
assert ExistePolicialNoDistrito{
	all dist:Distrito | #(dist.pol_vet ) = 3
	all dist:Distrito | #(dist.pol_nov) = 3 
	all dist:Distrito | #getXerifeDistrito[dist] = 1 
	all dist:Distrito |  #(dist.detetives) = 2
}

assert TestaChamadaAzul{
	all c:Cham_Azul | #(c.pol_vt + c.pol_nv + c.xer+c.det) = 4
}

assert TestaChamadaVermelha{
	all c:Cham_Vermelho | #(getPolicialChamada[c] + c.xer + getDetetiveChamVermelho[c]) = 5
}

/** Funcoes **/
fun getXerifeDistrito[d:Distrito] : set Xerife {
	(d.xerife)
}

fun getPolicialChamada[c:Chamada] : set Policial {
	(c.pol_vt + c.pol_nv)
}

fun getDetetiveChamVermelho[c:Cham_Vermelho] : set Detetive {
	(c.det)
}

/**Checks**/
check ExistePolicialNoDistrito
check TestaChamadaAzul
check TestaChamadaVermelha

/**show**/
pred show[]{
}

run show for 10
