# frozen_string_literal: true

# Brazilian phone numbers.
#
#
# NDC Reference
# http://www.anatel.gov.br/hotsites/CodigosNacionaisLocalidade/TelefoneCelular-CodigosDeArea.htm

 # 11 #Sao Paulo
 # 12 #Sao Paulo
 # 13 #Sao Paulo
 # 14 #Sao Paulo
 # 15 #Sao Paulo
 # 16 #Sao Paulo
 # 17 #Sao Paulo
 # 18 #Sao Paulo
 # 19 #Sao Paulo
 #
 # 21 #Rio de Janeiro
 # 22 #Rio de Janeiro
 #
 # 24 #Rio de Janeiro
 #
 # 27 #Espírito Santo
 # 28 #Espírito Santo
 #
 # 31 #Minas Gerais
 # 32 #Minas Gerais
 # 33 #Minas Gerais
 # 34 #Minas Gerais
 # 35 #Minas Gerais
 # 36 #Minas Gerais
 # 37 #Minas Gerais
 # 38 #Minas Gerais
 #
 # 41 #Paraná
 # 42 #Paraná
 # 43 #Paraná
 # 44 #Paraná
 # 45 #Paraná
 # 46 #Paraná
 # 47 #Santa Catarina
 # 48 #Santa Catarina
 # 49 #Santa Catarina
 #
 # 51 #Rio Grande do Sul
 # 52 #Rio Grande do Sul
 # 53 #Rio Grande do Sul
 # 54 #Rio Grande do Sul
 # 55 #Rio Grande do Sul
 #
 # 61 #Distrito Federal
 # 62 #Goiânia
 # 63 #Tocantins
 # 64 #Goiânia
 # 65 #Mato Grosso
 # 66 #Mato Grosso
 # 67 #Mato Grosso do Sul
 # 68 #Acre
 # 69 #Rondônia
 #
 # 71 #Bahia
 # 72 #Bahia
 # 73 #Bahia
 # 74 #Bahia
 # 75 #Bahia
 #
 # 77 #Bahia
 # 78 #Bahia
 # 79 #Sergipe
 #
 # 81 #Pernambuco
 # 82 #Alagoas
 # 83 #Paraíba
 # 84 #Rio Grande do Norte
 # 85 #Ceará
 # 86 #Piauí
 # 87 #Pernambuco
 # 88 #Ceará
 # 89 #Piauí
 #
 # 91 #Pará
 # 92 #Amazonas
 # 93 #Pará
 # 94 #Pará
 # 95 #Roraima
 # 96 #Amapá
 # 97 #Amazonas
 # 98 #Maranhão
 # 99 #Maranhão

ndcs = "(11|12|13|14|15|16|17|18|19|21|22|24|27|28|31|32|33|34|35|36|37|38|41|42|43|44|45|46|47|48|49|51|52|53|54|55|61|62|63|64|65|66|67|68|69|71|72|73|74|75|77|78|79|81|82|83|84|85|86|87|88|89|91|92|93|94|95|96|97|98|99)"

service = %w{ 100 128 190 191 192 193 194 197 198 199 } # State specific numbers were not added. See http://www.brasil.gov.br/navegue_por/aplicativos/agenda

special_numbers_3_4 = %w{ 0800 }
special_numbers_4 = %w{ 3003 4003 4004 4020 }

Phony.define do
  country '55',
    match(/^#{ndcs}9\d{8}$/)     >> split(5,4) |
    match(/^#{ndcs}\d{8}$/)      >> split(4,4) |
    one_of(special_numbers_3_4)  >> split(3,4) |
    one_of(special_numbers_4)    >> split(4) |
    one_of(service)              >> split(3) |
    fixed(3)                     >> split(3)
end
