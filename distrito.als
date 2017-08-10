module distrito

sig Distrito{
	policiais: set Policial 
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


pred show[]{
}

run show for 3
