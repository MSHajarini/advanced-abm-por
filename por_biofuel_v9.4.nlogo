;======================= insert extention ============================
extensions [ csv ]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; VARIABLES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;======================= create breeds ============================

breed [ pors por ] ;Port of Rotterdam authorities (por)
breed [ industries industry ] ;Biofuel and oil industries that are registered in Port of Rotterdam
breed [ new_factories new_factory ] ;new factory that will enter as new industry in  Port of Rotterdam

;======================= set global variables ============================
globals [

  tick_number                                   ; Tick of this turn ; unit: - ; type: float>0 ; initial: 0
  year                                          ; Year of the simulation  ; unit: - ; type: float>0 ; initial: 2019
  tick_min                                      ; Minimum tick of the simulation ; unit: - ; type: float>0 ; initial: 1
                                                ;advanced_counting                                   ; Advanced biofuel double counting on biofuel minimum limit ; unit: - ; type: float>0 ; initial: 2
  conventional_percent_max                      ; This tick onventional biofuel percentaga maximum  ; unit: % ; type: float>0 ; initial: 7
  advanced_percent_min                          ; Minimum advanced percentage this tick ; unit: % ; type: float>0 ; initial: 0.2
  biofuel_percent_min                                   ; Minimum biofuel mix in the road transport fuel (fix) ; unit: % ; type: float>0 ; initial: 7
  conventional_percent_max_data                                   ; Data on conventional biofuel maximum percentage  ; unit: % ; type: Data, float>0 ; initial: csv
  advanced_percent_min_data                                   ; Data on advance biofuel minimum percentage ; unit: % ; type: Data, float>0 ; initial: csv
  red_data                                   ; Data of RED II practice ; unit: - ; type: Data, float>0 ; initial: csv
                                             ;advanced_capex                                   ; This tick CAPEX of the advanced biofuel facility ; unit: €/ton/year ; type: float>0 ; initial: 1000
                                             ;advanced_opex                                   ; This tick  operation cost of the advanced biofuel facility ; unit: €/ton/year ; type: float>0 ; initial: 132.3
  advanced_capex_min                                   ; Advanced technology CAPEX minimum ; unit: €/ton/year ; type: float>0 ; initial: advanced_capex * 0.5
  advanced_opex_min                                   ; Advanced technology CAPEX maximum ; unit: €/ton/year ; type: float>0 ; initial: advanced_opex * 0.5
                                                      ;advanced_capacity                                   ; Set of this tick capacity choices of the advanced facility ; unit: €/ton/year ; type: float>0 ; initial: 800000
  advanced_capacity_max                                   ; Advanced technology capacity minimum ; unit: ton/year ; type: float>0 ; initial: advanced_capacity * 12.5
  advanced_capacity_min                                   ; Advanced technology capacity maximum ; unit: ton/year ; type: float>0 ; initial: advanced_capacity * 0.5
  advanced_capacity_factor                                   ; Advanced capacity factor for nex year to this year ; unit: - ; type: float>0 ; initial: 1
  advanced_capex_factor                                   ; Per year CAPEX decrease of the advanced biofuel facility ; unit: % ; type: float>0 ; initial: 1
  advanced_opex_factor                                   ; Per year operation cost decrease decrease of the advanced biofuel facility ; unit: % ; type: float>0 ; initial: 1
  advanced_demands_por                                   ; Advanced biofuel demands for PoR ; unit: ton/year ; type: float>0 ; initial: 0
                                                         ;advanced_demands_market                                   ; Advanced biofuel demands for market ; unit: ton/year ; type: float>0 ; initial: 0
                                                         ;por_advanced_market_percentage                                   ; Percetage of advanced biofuel market that PoR received from the world ; unit: % ; type: float>0 ; initial: 0.03
  advanced_demands_industries                                   ; Advanced biofuel demands for oil companies ; unit: ton/year ; type: float>0 ; initial: 0
  por_advanced_production                                   ; Advanced biofuel produced in PoR ; unit: ton/year ; type: float>0 ; initial: 0
  conventional_demands_market                                   ; Conventional biofuel demands in the market ; unit: ton/year ; type: float>0 ; initial: 0
  advanced_demands_market                                   ; Advanced biofuel demands in the market ; unit: ton/year ; type: float>0 ; initial: 0
  biofuel_demands_market                                   ; Biofuel demands in the market ; unit: ton/year ; type: float>0 ; initial: 0
                                                           ;oil_demands_market                                   ; Oil demands in the market ; unit: ton/year ; type: float>0 ; initial: 300 * 1000 * 1000 * 1000
                                                           ;oil_demands_market_increase                                   ; Oil demands in the market increase per year ; unit: % ; type: float>0 ; initial: -0.25
                                                           ;efficiency_effect                                   ; Efficiency effects in the oil market demands ; unit: % ; type: float>0 ; initial: 0
                                                           ;advanced_prices                                   ; This tick market price of the advanced biofuel ; unit: €/ton ; type: float>0 ; initial: 1760.02
                                                           ;advanced_prices_increase                                   ; This tick market price of the advanced biofuel increase ; unit: % ; type: float>0 ; initial: 0.1
                                                           ;oil_prices                                   ; This tick market price of the conventional fossil fuel ; unit: €/ton ; type: float>0 ; initial: 1760.02
                                                           ;oil_prices_increase                                   ; This tick market price increase of the oil biofuel ; unit: % ; type: float>0 ; initial: 0.75
                                                           ;conventional_prices                                   ; This tick market price of the conventional biofuel ; unit: €/ton ; type: float>0 ; initial: 1760.02
                                                           ;conventional_prices_increase                                   ; This tick market price increase of the conventional biofuel ; unit: % ; type: float>0 ; initial: 0.01
  advanced_feedstock_prices                                   ; This tick cost of the resources of the advanced biofuel facility ; unit: €/ton ; type: float>0 ; initial: 750
  advanced_feedstock_prices_opt                                   ; This tick cost of the resources of the advanced biofuel facility optimistic ; unit: €/ton ; type: float>0 ; initial: 520
  advanced_feedstock_prices_pes                                   ; This tick cost of the resources of the advanced biofuel facility pesimistic ; unit: €/ton ; type: float>0 ; initial: 750
                                                              ;advanced_feedstock_prices_increase                                   ; This tick market feeds increase of the advanced biofuel ; unit: % ; type: float>0 ; initial: 1
  advanced_prices_min                                   ; Minimum price of advanced biofuel ; unit: €/ton ; type: float>0 ; initial: advanced_prices * 0.1
  oil_prices_min                                   ; Minimum price of fossil fuel ; unit: €/ton ; type: float>0 ; initial: oil_prices * 0.1
  conventional_prices_min                                   ; Minimum price of coventioal biofuel ; unit: €/ton ; type: float>0 ; initial: conventional_prices * 0.1
  oil_prices_max                                   ; Maximum price of fossil fuel ; unit: €/ton ; type: float>0 ; initial: oil_prices * 5
  conventional_prices_max                                   ; Maximum price of conventioal biofuel ; unit: €/ton ; type: float>0 ; initial: conventional_prices * 5
  advanced_prices_max                                   ; Maximum price of advanced biofuel ; unit: €/ton ; type: float>0 ; initial: advanced_prices * 5
  advanced_feedstock_prices_max                                   ; Maximum price of advanced biofuel feedstock ; unit: €/ton ; type: float>0 ; initial: advanced_feedstock_prices_pes * 3.0
  por_open?                                   ; Decision if PoR open for new advanced biofuel industry ; unit: - ; type: BOOLEAN ; initial: FALSE
  por_oil_production                                   ; Oil produced in the PoR ; unit: ton/year ; type: float>0 ; initial: sum [oil_production] of industries
  por_conventional_production                                   ; Conventional biofuel produced in the PoR ; unit: ton/year ; type: float>0 ; initial: sum [conventional_production] of industries
  por_advanced_production_industries                                                   ; Advanced  biofuel produced by old companies in the PoR ; unit: ton/year ; type: float>0 ; initial: 0
  por_advanced_production_new                                   ; Advanced  biofuel produced by new companies in the PoR ; unit: ton/year ; type: float>0 ; initial: 0
  advanced_demand_industries                                   ; Advanced  biofuel demanded by old companies in the PoR ; unit: ton/year ; type: float>0 ; initial: 0
  por_subsidy_budget                             ; PoR subsidy limit per year ; unit: €/year ; type: float>0 ; initial: 0
                                                               ;subsidy_perton                                   ; PoR subsidy given per liter of advanced biofuel produced ; unit: €/ton ; type: float>0 ; initial: 0
                                                               ;tax                                   ; Tax for production ; unit: % ; type: float>0 ; initial: 0
                                                               ;subsidy_onetime                                   ; PoR one time capital subsidy ; unit: € ; type: float>0 ; initial: 0
                                                               ;PoR_connection_reduced_risk                                   ; Reduced risk caused by PoR connection ; unit: % ; type: float>0 ; initial: 0.5
  area_available_for_advanced                                   ; Available area  to make advanced biofuel facility ; unit: m2 ; type: float>0 ; initial: 0
                                                                ;area_advanced                                   ; Area needed to make advanced biofuel facility per facility capacity ; unit: m2 ; type: float>0 ; initial: 40
  area_advanced_total                                   ; Total area used for advanced biofuel facility per facility capacity  ; unit: m2 ; type: float>0 ; initial: 0
  initial_area_advanced                                   ; Initial available area  to make advanced biofuel facility ; unit: m2 ; type: float>0 ; initial: 750
  advanced_feedstock_dues                                   ; Dues directed to feedstock for advanced biofuel ; unit: % ; type: float>0 ; initial: 0
  oil_feedstock_dues                                   ; Dues directed to oil crude ; unit: % ; type: float>0 ; initial: 0
  conventional_feedstock_dues                                   ; Dues directed to feedstock for conventional biofuel ; unit: % ; type: float>0 ; initial: 0
  advanced_dues                                   ; Dues directed to  advanced biofuel ; unit: % ; type: float>0 ; initial: 0
  oil_dues                                   ; Dues directed to fossil fuel ; unit: % ; type: float>0 ; initial: 0
  conventional_dues                                   ; Dues directed to conventional biofuel ; unit: % ; type: float>0 ; initial: 0
                                                        ;join_pora_percent                                   ; Percentage of joining PoR ; unit: % ; type: float>0 ; initial: 5
                                                        ;wacc_max                                   ; Weighted average cost of capital maximum for advanced biofuel ; unit: % ; type: float>0 ; initial: 30
                                                        ;wacc_min                                   ; Weighted average cost of capital minimum for advanced biofuel ; unit: % ; type: float>0 ; initial: 20
  wacc_max_mem                                   ; Weighted average cost of capital maximum memory for advanced biofuel ; unit: % ; type: float>0 ; initial: 0
  wacc_min_mem                                   ; Weighted average cost of capital minimum memory for advanced biofuel ; unit: % ; type: float>0 ; initial: 0
                                                 ;wacc_rate                                   ; Decreasing rate of wacc for advanced biofuel ; unit: % ; type: float>0 ; initial: 0.03
                                                 ;wacc_conventional_min                                   ; Weighted average cost of capital minimum for conventional biofuel ; unit: % ; type: float>0 ; initial: 6.3
                                                 ;wacc_conventional_max                                   ; Weighted average cost of capital maximum for conventional biofuel ; unit: % ; type: float>0 ; initial: 12.8
                                                 ;availability_input                                   ; plan to be available as percentage per year as input ; unit: % ; type: float>0 ; initial: 90
                                                 ;avalability_variance                                   ; plan to be available as percentage per year as input ; unit: % ; type: float>0 ; initial: 10
  number_of_companies                                   ; Number of companies ; unit: - ; type: float>0 ; initial: 10
  number_of_new_companies                                   ; Number of new companies ; unit: - ; type: float>0 ; initial: 100
  advanced_opex_1_percent                                   ; Advanced refinery opex classifier category 1 ; unit: % ; type: float>0 ; initial: 1
  advanced_opex_2_percent                                   ; Advanced refinery opex classifier category 2 ; unit: % ; type: float>0 ; initial: 1.5
  advanced_opex_3_percent                                   ; Advanced refinery opex classifier category 3 ; unit: % ; type: float>0 ; initial: 2
  advanced_opex_4_percent                                   ; Advanced refinery opex classifier category 4 ; unit: % ; type: float>0 ; initial: 2.5
  advanced_opex_5_percent                                   ; Advanced refinery opex classifier category 5 ; unit: % ; type: float>0 ; initial: 3
  advanced_capacity_1_percent                                   ; Advanced refinery capacity classifier category 1 ; unit: % ; type: float>0 ; initial: 1
  advanced_capacity_2_percent                                   ; Advanced refinery capacity classifier category 2 ; unit: % ; type: float>0 ; initial: 0.8
  advanced_capacity_3_percent                                   ; Advanced refinery capacity classifier category 3 ; unit: % ; type: float>0 ; initial: 0.6
  advanced_capacity_4_percent                                   ; Advanced refinery capacity classifier category 4 ; unit: % ; type: float>0 ; initial: 0.4
  advanced_capacity_5_percent                                   ; Advanced refinery capacity classifier category 5 ; unit: % ; type: float>0 ; initial: 0.2
  advanced_capex_1_percent                                   ; Advanced refinery capex classifier category 1 ; unit: % ; type: float>0 ; initial: 1
  advanced_capex_2_percent                                   ; Advanced refinery capex classifier category 2 ; unit: % ; type: float>0 ; initial: 0.88
  advanced_capex_3_percent                                   ; Advanced refinery capex classifier category 3 ; unit: % ; type: float>0 ; initial: 0.78
  advanced_capex_4_percent                                   ; Advanced refinery capex classifier category 4 ; unit: % ; type: float>0 ; initial: 0.64
  advanced_capex_5_percent                                   ; Advanced refinery capex classifier category 5 ; unit: % ; type: float>0 ; initial: 0.4
  advanced_opex_1                                   ; Advanced refinery opex category 1 ; unit: €/ton/year ; type: float>0 ; initial: advanced_opex * advanced_opex_1_percent
  advanced_opex_2                                   ; Advanced refinery opex category 2 ; unit: €/ton/year ; type: float>0 ; initial: advanced_opex * advanced_opex_2_percent
  advanced_opex_3                                   ; Advanced refinery opex category 3 ; unit: €/ton/year ; type: float>0 ; initial: advanced_opex * advanced_opex_3_percent
  advanced_opex_4                                   ; Advanced refinery opex category 4 ; unit: €/ton/year ; type: float>0 ; initial: advanced_opex * advanced_opex_4_percent
  advanced_opex_5                                   ; Advanced refinery opex category 5 ; unit: €/ton/year ; type: float>0 ; initial: advanced_opex * advanced_opex_4_percent
  advanced_capex_1                                   ; Advanced refinery capex category 1 ; unit: €/ton/year ; type: float>0 ; initial: advanced_capex * advanced_capex_1_percent
  advanced_capex_2                                   ; Advanced refinery capex category 2 ; unit: €/ton/year ; type: float>0 ; initial: advanced_capex * advanced_capex_2_percent
  advanced_capex_3                                   ; Advanced refinery capex category 3 ; unit: €/ton/year ; type: float>0 ; initial: advanced_capex * advanced_capex_3_percent
  advanced_capex_4                                   ; Advanced refinery capex category 4 ; unit: €/ton/year ; type: float>0 ; initial: advanced_capex * advanced_capex_4_percent
  advanced_capex_5                                   ; Advanced refinery capex category 5 ; unit: €/ton/year ; type: float>0 ; initial: advanced_capex * advanced_capex_5_percent
  advanced_capacity_1                                   ; Advanced refinery capacity category 1 ; unit: ton/year ; type: float>0 ; initial: advanced_capacity * advanced_capacity_1_percent
  advanced_capacity_2                                   ; Advanced refinery capacity category 2 ; unit: ton/year ; type: float>0 ; initial: advanced_capacity * advanced_capacity_2_percent
  advanced_capacity_3                                   ; Advanced refinery capacity category 3 ; unit: ton/year ; type: float>0 ; initial: advanced_capacity * advanced_capacity_3_percent
  advanced_capacity_4                                   ; Advanced refinery capacity category 4 ; unit: ton/year ; type: float>0 ; initial: advanced_capacity * advanced_capacity_4_percent
  advanced_capacity_5                                   ; Advanced refinery capacity category 5 ; unit: ton/year ; type: float>0 ; initial: advanced_capacity * advanced_capacity_5_percent
  adoption_weight_scale                                   ; adoption based on number of consumer ; unit: - ; type: float>0 ; initial: 0
  number_of_adopter                                   ; number of adopter of advanced biofuel ; unit: - ; type: float>0 ; initial: 0
  technology_adoption                                   ; technology adoption percentage ; unit: % ; type: float>0 ; initial: 0
  innovator_percent                                   ; technology adoption percentage for innovator 2.5 % ; unit: % ; type: float>0 ; initial: 0
  early_adopter_percent                                   ; technology adoption percentage for Early Adopters (13.5%) ; unit: % ; type: float>0 ; initial: 0.025
  early_majority_percent                                   ; technology adoption percentage for Early Majority (34%) ; unit: % ; type: float>0 ; initial: 0.16
  late_majority_percent                                   ; technology adoption percentage for Late Majority (34%) ; unit: % ; type: float>0 ; initial: 0.5
  laggards_percent                                   ; technology adoption percentage for Laggards (16%) ; unit: % ; type: float>0 ; initial: 0.84
  adoption_phase                                   ; adoption phase of advanced technology ; unit: - ; type: float>0 ; initial: 0
  advanced_scale_factor                                   ; scale factor for advanced biofuel technology this tick ; unit: - ; type: float>0 ; initial: 0.75
  advanced_scale_factor_min                                   ; empirical minimum scale factor for advanced biofuel technology ; unit: - ; type: float>0 ; initial: 0.6
  advanced_scale_factor_max                                   ; empirical maximum scale factor for advanced biofuel technology ; unit: - ; type: float>0 ; initial: 0.9
  advanced_doubling_time                                   ; capacity doubling time for advanced biofuel technology this tick ; unit: - ; type: float>0 ; initial: 4
  advanced_doubling_time_min                                   ; empirical minimum capacity doubling time for advanced biofuel technology ; unit: - ; type: float>0 ; initial: 3
  advanced_doubling_time_max                                   ; empirical maximum capacity doubling time for advanced biofuel technology ; unit: - ; type: float>0 ; initial: 5
  x                                   ; taking turn as x for industries ; unit: - ; type: float>0 ; initial: 0
  oil_production_industries                                   ; oil production industries list ; unit: ton/year ; type: float>0 ; initial: 0
  conventional_production_industries                                   ; comventional production indutries list ; unit: ton/year ; type: float>0 ; initial: 0
  upgrade_capex                                   ; Upgrading advance biofuel refinery capex in Meuro ; unit: M€/ton/year ; type: float>0 ; initial: 300
  upgrade_capex_mem                                   ; Upgrading advance biofuel refinery capex in euro ; unit: €/ton/year ; type: float>0 ; initial: upgrade_capex * 1000000
  upgrade_capacity                                   ; Upgrading advance biofuel refinery capacity ; unit: ton/year ; type: float>0 ; initial: 750000
  upgrade_capex_min                                   ; Upgrading advance biofuel refinery capex in Meuro minimum ; unit: M€/ton/year ; type: float>0 ; initial: upgrade_capex_mem * 0.5
  upgrade_capex_max                                   ; Upgrading advance biofuel refinery capex in Meuro maximum ; unit: M€/ton/year ; type: float>0 ; initial: upgrade_capex_mem* 2
  upgrade_capacity_min                                   ; Upgrading advance biofuel refinery minimum capacity ; unit: ton/year ; type: float>0 ; initial: upgrade_capacity * 0.01
  upgrade_capacity_max                                   ; Upgrading advance biofuel refinery maximum capacity ; unit: ton/year ; type: float>0 ; initial: upgrade_capacity * 2
  industry_turn                                   ; Turn to think about changing to biofuel ; unit: - ; type: float>0 ; initial: 0
  number_of_biofuel_companies                                   ; Number of biofuel companies in the Port ; unit: - ; type: float>0 ; initial: 4
  upgrade_capacity_1_percent                                   ; Upgrading advance biofuel refinery capacity classifier category 1 ; unit: % ; type: float>0 ; initial: 1
  upgrade_capacity_2_percent                                   ; Upgrading advance biofuel refinery capacity classifier category 2 ; unit: % ; type: float>0 ; initial: 0.67
  upgrade_capacity_3_percent                                   ; Upgrading advance biofuel refinery capacity classifier category 3 ; unit: % ; type: float>0 ; initial: 0.33
  upgrade_capacity_4_percent                                   ; Upgrading advance biofuel refinery capacity classifier category 4 ; unit: % ; type: float>0 ; initial: 0.2
  upgrade_capex_1_percent                                   ; Upgrading advance biofuel refinery capex classifier category 1 ; unit: % ; type: float>0 ; initial: 1
  upgrade_capex_2_percent                                   ; Upgrading advance biofuel refinery capex classifier category 2 ; unit: % ; type: float>0 ; initial: 0.78
  upgrade_capex_3_percent                                   ; Upgrading advance biofuel refinery capex classifier category 3 ; unit: % ; type: float>0 ; initial: 0.52
  upgrade_capex_4_percent                                   ; Upgrading advance biofuel refinery capex classifier category 4 ; unit: % ; type: float>0 ; initial: 0.38
  upgrade_capacity_1                                   ; Upgrading advance biofuel refinery capacity category 1 ; unit: ton/year ; type: float>0 ; initial: upgrade_capacity * upgrade_capacity_1_percent
  upgrade_capacity_2                                   ; Upgrading advance biofuel refinery capacity category 2 ; unit: ton/year ; type: float>0 ; initial: upgrade_capacity * upgrade_capacity_2_percent
  upgrade_capacity_3                                   ; Upgrading advance biofuel refinery capacity category 3 ; unit: ton/year ; type: float>0 ; initial: upgrade_capacity * upgrade_capacity_3_percent
  upgrade_capacity_4                                   ; Upgrading advance biofuel refinery capacity category 4 ; unit: ton/year ; type: float>0 ; initial: upgrade_capacity * upgrade_capacity_4_percent
  upgrade_capex_1                                   ; Upgrading advance biofuel refinery capex category 1 ; unit: €/ton/year ; type: float>0 ; initial: upgrade_capex * upgrade_capex_1_percent
  upgrade_capex_2                                   ; Upgrading advance biofuel refinery capex category 2 ; unit: €/ton/year ; type: float>0 ; initial: upgrade_capex * upgrade_capex_2_percent
  upgrade_capex_3                                   ; Upgrading advance biofuel refinery capex category 3 ; unit: €/ton/year ; type: float>0 ; initial: upgrade_capex * upgrade_capex_3_percent
  upgrade_capex_4                                   ; Upgrading advance biofuel refinery capex category 4 ; unit: €/ton/year ; type: float>0 ; initial: upgrade_capex * upgrade_capex_4_percent
  upgrade_capacity_factor                                   ; Upgrading advance biofuel refinery capacity factor ; unit: - ; type: float>0 ; initial: 0
  upgrade_capex_factor                                   ; Upgrading advance biofuel refinery capex factor ; unit: - ; type: float>0 ; initial: 0
  number_of_industries                                   ; Number of industries ; unit: - ; type: float>0 ; initial: 10
                                                         ;number_of_new_factories                                    ; Number of new factories (potential) ; unit: - ; type: float>0 ; initial: 100
  companies_data                                   ; Data of companies in PoR ; unit: - ; type: table ; initial: csv
  companies_label                                   ; Data of companies in PoR, label ; unit: - ; type: string ; initial: csv
  advanced_demands_market_por                                   ; Advanced demands market for PoR ; unit: ton/year ; type: float>0 ; initial: 0
  area_taken                                   ; Area taken not for advanced biofuel factories ; unit: m2 ; type: float>0 ; initial: 0
  advanced_capex_mem                                   ; Advanced technology CAPEX ; unit: €/ton/year ; type: float>0 ; initial: advanced_capex * 1000000
  conventional_demands_possibility                                   ; Possibility of conventional biofuel demands ; unit: ton/year ; type: float>0 ; initial: set conventional_demands_possibility_
  conventional_demands_possibility_por                                   ; Possibility of conventional biofuel demands in PoR ; unit: ton/year ; type: float>0 ; initial: (conventional_demands_possibility * (por_conventional_market_percentage / 100))
                                                                         ;por_conventional_market_percentage                                   ; Market share of conventional biofuel from Rotterdam vs  European consupmtions ; unit: % ; type: float>0 ; initial: 0.005
  first_join_year_new                                   ; The first year new factories joining POR ; unit: - ; type: float>0 ; initial: 0
  first_convert_year_industries                                   ; The first year industries convert to biofuel ; unit: - ; type: float>0 ; initial: 0

  sum_new_advanced_por                                   ; Number of total new factories going to advanced biofuel in POR ; unit: - ; type: float>0 ; initial: sum [join_por] of new_factories
  sum_new_advanced                                   ; Number of total new factories going to advanced biofuel ; unit: - ; type: float>0 ; initial: sum [join_advance] of new_factories
  sum_new_advance_por_percent                                   ; Number of total new factories going to advanced biofuel in POR percentage ; unit: % ; type: float>0 ; initial: join por/join advance
  sum_converted_industries                                   ; Number of converted industries ; unit: - ; type: float>0 ; initial: sum [add_advance] of industries
  sum_subsidy_onetime                                   ; Sum of onetime subsidy from POR ; unit: € ; type: float>0 ; initial: sum [subsidy_onetime_here] of new_factories
  sum_subsidy_perton                                   ; Sum of perton subsidy from POR ; unit: € ; type: float>0 ; initial: sum [subsidy_perton] of new_factories * sum [demands] of new_factories * 10

  market_new_advanced_production                                   ; Sum of new factories advanced biofuel production ; unit: ton/year ; type: float>0 ; initial:
  market_advanced_production                                   ; Sum of all advanced biofuel production in the market ; unit: ton/year ; type: float>0 ; initial:

]

;======================= set new factories variables ============================
new_factories-own [

  join_advance?         ;Status if new companies join advanced or not ; unit: - ; type: BOOLEAN ; initial: FALSE
  join_por?         ;Status if new companies join PoR or not ; unit: - ; type: BOOLEAN ; initial: FALSE
  availability         ;plan to be available as percentage per year ; unit: % ; type: float>0 ; initial: 0
  capacity         ;Advanced biofuel capacity plan for this new company ; unit: ton/year ; type: float>0 ; initial: 0
  opex         ;OPEX of advanced biofuel plan this year ; unit: €/ton ; type: float>0 ; initial: 0
  capex         ;CAPEX of advanced biofuel plant this year ; unit: €/ton/year ; type: float>0 ; initial: 0
  demands_mem         ;Yearly capacity after being multiplied by availability ; unit: ton ; type: float>0 ; initial: 0
  demands         ;Demands this year after considering number of global demands ; unit: ton ; type: float>0 ; initial: 0
  feedstock_prices_mem         ;Feedstock price after being increased by port dues ; unit: €/ton ; type: float>0 ; initial: 0
  profit_mem         ;Profit before tax ; unit: € ; type: float>0 ; initial: 0
  profit         ;Profit after tax ; unit: € ; type: float>0 ; initial: 0
  invested_capital_por         ;capital that needed to make the facility in the port ; unit: € ; type: float>0 ; initial: 0
  roic         ;Return on invested capital ; unit: % ; type: float>0 ; initial: 0
  reduced_risk_percent         ;Reduced risk after being helped by PoR ; unit: % ; type: float>0 ; initial: 0
  wacc         ;Weighted average cost of capital ; unit: % ; type: float>0 ; initial: 0
  min_roic         ;Minimum ROIC to make start bussiness ; unit: % ; type: float>0 ; initial: 0
  join_por         ;Auxilary variable for probability to join POR ; unit: - ; type: float>0 ; initial: 0
  join_year         ;New companies join year in advanced biofuel bussiness ; unit: - ; type: float>0 ; initial: 0
  category         ;The facility category for the industry ; unit: - ; type: float>0 ; initial: 0
  capacity_mem         ;The  production that is wished to be made ; unit: ton ; type: float>0 ; initial: 0
  join_advance         ;Status if new companies join advanced or not in float ; unit: - ; type: float>0 ; initial: 0
  join_por_random         ;Set randomness on joining POR or other places ; unit: - ; type: float>0 ; initial: 0
  not_por?         ;Status of a company that already joining advanced biofuel but not in POR ; unit: - ; type: BOOLEAN ; initial: FALSE
  profit_mem_por         ;Profit for using POR facility and subsidy ; unit: € ; type: float>0 ; initial: 0
  profit_por         ;Profit without using POR facility and subsidy ; unit: € ; type: float>0 ; initial: 0
  roic_por         ;ROIC for using POR facility and subsidy ; unit: - ; type: float>0 ; initial: 0
  subsidy_onetime_here         ;One time subsidu given for specific company ; unit: € ; type: float>0 ; initial: 0
  roic_absolut         ;roic that show absolut value company want to join/not POR ; unit: - ; type: float>0 ; initial: 0
  extra_possibility_percent         ;Extra possibility to join POR because internal demands ; unit: % ; type: float>0 ; initial: 20
  production         ;Advanced biofuel production plan for this new company ; unit: ton/year ; type: float>0 ; initial: 0


]

;======================= set incumbent industries variables ============================
industries-own [

  oil_production    ;Oil produced by companies ; unit: ton/year ; type: float>0 ; initial: csv
  conventional_production    ;Conventional biofuel produced by companies ; unit: ton/year ; type: float>0 ; initial: csv
  advanced_production    ;Advanced biofuel produced by companies ; unit: ton/year ; type: float>0 ; initial: 0
  advanced_demands    ;Advanced biofuel demanded by companies ; unit: ton/year ; type: float>0 ; initial: 0
  conventional_demands    ;Conventional biofuel demamded by companies ; unit: ton/year ; type: float>0 ; initial: 0
  biofuel_demands    ;Biofuel demanded by companies ; unit: ton/year ; type: float>0 ; initial: 0
  advanced_demands_s1    ;Advanced biofuel demanded by companies scenario 1 ; unit: ton/year ; type: float>0 ; initial: 0
  advanced_demands_s2    ;Advanced biofuel demanded by companies scenario 2 ; unit: ton/year ; type: float>0 ; initial: 0
  add_advance?    ;Decision to convert production to advanced biofuel ; unit: - ; type: Boolean, TRUE/FALSE ; initial: FALSE
  add_advance    ;Decision to convert production to advanced biofuel in float ; unit: - ; type: float>0 ; initial: 0
  availability    ;The predicted availability of the plan ; unit: % ; type: float>0 ; initial: 0
  wacc    ;The weighted average cost of capital of the advanced biofuel upgrade ; unit: % ; type: float>0 ; initial: 0
  capacity_mem    ;The conventional production that is wished to be changed to advanced biofuel production ; unit: ton/year ; type: float>0 ; initial: 0
  category    ;The facility category for the industry ; unit: - ; type: float>0 ; initial: 0
  opex    ;Advanced biofuel opex ; unit: €/ton/year ; type: float>0 ; initial: 0
  capex    ;Advanced biofuel capex ; unit: €/ton/year ; type: float>0 ; initial: 0
  feedstock_prices_mem    ;Advanced biofuel feedstock price ; unit: €/ton ; type: float>0 ; initial: 0
  profit_mem    ;Advanced biofuel profit per ton ; unit: €/ton ; type: float>0 ; initial: 0
  profit    ;Advanced biofuel profit ; unit: € ; type: float>0 ; initial: 0
  invested_capital    ;The number of investation for the advanced biofuel facility ; unit: € ; type: float>0 ; initial: 0
  roic    ;Return of invested capital from making the biofuel facility ; unit: - ; type: float>0 ; initial: 0
  reduced_risk_percent    ;The reduced risk comes from POR ; unit: % ; type: float>0 ; initial: 0
  min_roic    ;The minimum return of invested capital to go ; unit: - ; type: float>0 ; initial: 0
  join_year    ;The year joining advanced facility ; unit: year ; type: float>0 ; initial: 0
  demands    ;Demands on changing to advanced biofuel ; unit: tons ; type: float>0 ; initial: 0
  oil_production_input    ;Input from csv on the oil production of industries ; unit: tons ; type: float>0 ; initial: csv
  conventional_production_input    ;Input from csv on the conventional production of industries ; unit: tons ; type: float>0 ; initial: csv
  capacity    ;Advanced biofuel capacity plan for this industries ; unit: ton/year ; type: float>0 ; initial: 0
]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SETUP PROCEDURES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to setup_optional

  setup_image

  set PoR_connection_reduced_risk 0.5
  set subsidy_onetime 0
  set subsidy_perton 0
  set advanced_feedstock_prices_opt_init 520.0
  set advanced_feedstock_prices_pes_init 750.0
  set area_advanced 50


  set advanced_feedstock_prices_increase 1
  set join_pora_percent 5
  set advanced_prices_increase 0.1

end

to setup_experiment_seed

  random-seed 42 + behaviorspace-run-number

end


to setup

;Close any files open from last run
  clear-all
  file-close-all

  ;set the images for interface purpose
  setup_image

  ;Setup the lists
  setup_lists

  ;Read data from the csv files
  read_industry
  read_redii
  setup_por

  ;Setup turtles and variables
  setup_industries ;setup industries to turtles 0 to 9
  setup_new_factories ; setup new factories to turtles 10 to ...

  setup_global

  reset-ticks
end

to setup_por

  set advanced_feedstock_prices_pes advanced_feedstock_prices_pes_init
  set advanced_feedstock_prices_opt advanced_feedstock_prices_opt_init

  set por_open? FALSE
  set por_oil_production sum [oil_production] of industries
  set por_conventional_production sum [conventional_production] of industries
  set por_advanced_production_industries 0.0
  set por_advanced_production_new 0
  set advanced_demands_industries 0
  set por_subsidy_budget 0
  set tax 0

  set area_advanced_total 0
  set initial_area_advanced 750

  set area_available_for_advanced initial_area_advanced
  set advanced_feedstock_dues 0
  ;set oil_feedstock_dues 0
  set conventional_feedstock_dues 0
  set advanced_dues 0
  set oil_dues 0
  set conventional_dues 0
end


to setup_lists
  set oil_production_industries []
  set conventional_production_industries []
  set companies_label []
  set conventional_percent_max_data []
  set advanced_percent_min_data []
end

;======================= setup global at t=0 ============================
to setup_global

  set advanced_demands_market_por 0
  set area_taken 0

  set conventional_percent_max item 0 conventional_percent_max_data
  set advanced_percent_min item 0 advanced_percent_min_data

  set tick_number 0
  set year 2019
  set tick_min 1
  set advanced_counting 2
  set conventional_percent_max 7
  set advanced_percent_min 0.2
  set biofuel_percent_min 7

  set advanced_capex 1000
  set advanced_capex_mem advanced_capex * 1000000
  set advanced_opex 132.300
  set advanced_capex_min advanced_capex * 0.1
  set advanced_opex_min advanced_opex * 0.1
  set advanced_capacity 800000.00
  set advanced_capacity_max advanced_capacity * 12.5
  set advanced_capacity_factor 1.0
  set advanced_capex_factor 1.0
  set advanced_opex_factor 1.0

  set advanced_demands_por 0
  set advanced_demands_market 0
  set por_advanced_market_percentage 0.03 ;same with oil percentage
  set por_conventional_market_percentage 0.005 ;using 7% in 2019
  set advanced_demands_industries 0
  set por_advanced_production 0
  set conventional_demands_market 0
  set advanced_demands_market 0
  set biofuel_demands_market 0
  set oil_demands_market  300 * 1000 * 1000 * 1000
  set oil_demands_market_increase -0.25
  set efficiency_effect 0
  set advanced_prices 1760.02
  set oil_prices 1760.02
  set oil_prices_increase 0.75
  set conventional_prices 1760.02
  set conventional_prices_increase 0.01

  set advanced_feedstock_prices advanced_feedstock_prices_opt + (random (advanced_feedstock_prices_pes - advanced_feedstock_prices_opt))

  set advanced_feedstock_prices_max advanced_feedstock_prices_pes * 10.0

  set advanced_prices_min advanced_prices * 0.1
  set oil_prices_min oil_prices * 0.1
  set conventional_prices_min conventional_prices * 0.1
  set oil_prices_max oil_prices * 5
  set conventional_prices_max conventional_prices * 5
  set advanced_prices_max advanced_prices * 5

  set wacc_max 30
  set wacc_min 20
  set wacc_max_mem 0
  set wacc_min_mem 0
  set wacc_rate 0.03
  set wacc_conventional_min 6.3
  set wacc_conventional_max 12.8

  set availability_input 90
  ;set variance_factory 10

  ;new

  set advanced_doubling_time_max 5.0
  set  advanced_doubling_time_min 3.0
  set advanced_doubling_time advanced_doubling_time_min
  set advanced_scale_factor_max 0.9
  set advanced_scale_factor_min 0.6

  ;new
  set innovator_percent  0 / 100
  set early_adopter_percent 2.5 / 100
  set early_majority_percent 16 / 100
  set late_majority_percent 50 / 100
  set laggards_percent 84 / 100


  set advanced_opex_1_percent 1
  set advanced_opex_2_percent 1.5
  set advanced_opex_3_percent 2
  set advanced_opex_4_percent 2.5
  set advanced_opex_5_percent   3

  set advanced_capacity_1_percent   1
  set advanced_capacity_2_percent 0.8
  set advanced_capacity_3_percent 0.6
  set advanced_capacity_4_percent 0.4
  set advanced_capacity_5_percent  0.2

  set advanced_capex_1_percent   1
  set advanced_capex_2_percent 0.88
  set advanced_capex_3_percent 0.78
  set advanced_capex_4_percent 0.64
  set advanced_capex_5_percent   0.4

  set advanced_opex_1  advanced_opex * advanced_opex_1_percent
  set advanced_opex_2 advanced_opex * advanced_opex_2_percent
  set advanced_opex_3 advanced_opex * advanced_opex_3_percent
  set advanced_opex_4 advanced_opex * advanced_opex_4_percent
  set advanced_opex_5   advanced_opex * advanced_opex_4_percent

  set advanced_capex_1 advanced_capex_mem * advanced_capex_1_percent
  set advanced_capex_2 advanced_capex_mem * advanced_capex_2_percent
  set advanced_capex_3 advanced_capex_mem * advanced_capex_3_percent
  set advanced_capex_4 advanced_capex_mem * advanced_capex_4_percent
  set advanced_capex_5 advanced_capex_mem * advanced_capex_5_percent

  set advanced_capacity_1 advanced_capacity * advanced_capacity_1_percent
  set advanced_capacity_2 advanced_capacity * advanced_capacity_2_percent
  set advanced_capacity_3 advanced_capacity * advanced_capacity_3_percent
  set advanced_capacity_4 advanced_capacity * advanced_capacity_4_percent
  set advanced_capacity_5 advanced_capacity * advanced_capacity_5_percent

  set upgrade_capex 300
  set upgrade_capex_mem upgrade_capex * 1000000
  set upgrade_capacity 750000
  set upgrade_capex_min upgrade_capacity * 0.5
  set upgrade_capex_max upgrade_capacity * 2
  set upgrade_capacity_min upgrade_capacity * 0.01
  set upgrade_capacity_max upgrade_capacity * 2

  set industry_turn 0


  set upgrade_capacity_1_percent 1
  set upgrade_capacity_2_percent 0.67
  set upgrade_capacity_3_percent 0.33
  set upgrade_capacity_4_percent 0.2

  set upgrade_capex_1_percent 1
  set upgrade_capex_2_percent 0.78
  set upgrade_capex_3_percent 0.52
  set upgrade_capex_4_percent 0.38

  set upgrade_capacity_1 upgrade_capacity * upgrade_capacity_1_percent
  set upgrade_capacity_2 upgrade_capacity * upgrade_capacity_2_percent
  set upgrade_capacity_3 upgrade_capacity * upgrade_capacity_3_percent
  set upgrade_capacity_4 upgrade_capacity * upgrade_capacity_4_percent

  set upgrade_capex_1 upgrade_capex * upgrade_capex_1_percent
  set upgrade_capex_2 upgrade_capex * upgrade_capex_2_percent
  set upgrade_capex_3 upgrade_capex * upgrade_capex_3_percent
  set upgrade_capex_4 upgrade_capex * upgrade_capex_4_percent


  ;conventional market possibility this year
  set conventional_demands_possibility (oil_demands_market * (conventional_percent_max / 100))
  set conventional_demands_possibility_por (conventional_demands_possibility * (por_conventional_market_percentage / 100))

  set first_join_year_new 0
  set first_convert_year_industries 0
  set sum_new_advanced_por 0
  set sum_new_advanced 0
  set sum_new_advance_por_percent 0
  set sum_converted_industries 0
  set sum_subsidy_onetime 0
  set sum_subsidy_perton 0

  set market_new_advanced_production 0
  set market_advanced_production 0


end

;======================= setup industries  at t=0 ============================
to setup_industries

  ;set number of agents
  set number_of_new_factories 100

  ;set number of agents
  set number_of_industries 10
  create-industries number_of_industries

  ;  set x 0
  ;  while [ x < (number_of_industries) ]
  ;  [ ask industry x [
  ;    set label item x companies_label
  ;    set oil_production_input item x oil_production_industries
  ;    set conventional_production_input item x conventional_production_industries
  ;    set x x + 1  ]]

  ask industries [
    set label item who companies_label
    set oil_production_input item who oil_production_industries
    set conventional_production_input item who conventional_production_industries
  ]

  ask industries
    [
      set shape "factory"
      set color orange
      set size 5
      set label-color black
      setxy random-pxcor random-pycor
      set oil_production oil_production_input
      set conventional_production conventional_production_input
      set advanced_production 0
      set advanced_demands 0
      set conventional_demands 0
      set biofuel_demands 0
      set advanced_demands_s1 0
      set advanced_demands_s2 0
      set join_year 10000
  ]

  set number_of_biofuel_companies count industries with [conventional_production > 1]

end

;======================= setup new factories  at t=0 ============================
to setup_new_factories
  create-new_factories number_of_new_factories
  ask new_factories
  [
    set join_advance? FALSE
    set join_por? FALSE
    set availability 0
    set capacity 0
    set opex 0
    set capex 0
    set demands_mem 0
    set demands 0
    set feedstock_prices_mem 0
    set profit_mem 0
    set profit 0
    set invested_capital_por 0
    set roic 0
    set reduced_risk_percent 0
    set wacc 0
    set min_roic 0
    set join_por 0
    set join_year 10000

    set join_advance 0
    set join_por_random 0
    set not_por? FALSE

    set roic_absolut 0
    set extra_possibility_percent 0

    set production 0
  ]
end

;======================= setup time  at t=0 ============================

;======================= setup images in the interface  at t=0 ============================
to setup_image
  if not file-exists? "portofrotterdam.PNG" [
    user-message "No file 'portofrotterdam.PNG'exists!"
    stop
  ]
  import-drawing "portofrotterdam.jpg"
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; GO PROCEDURES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to go

  technology_advancement
  market_demands
  set_wacc
  join_advanced_new
  buy_biofuel
  sum_por_demands
  change_biofuel

  update_world
  calculate_kpi

  ;used for debug process ================= deactivated when not used in experiment =========== manual
  ;print_job


  ;end simulation
  if year > 2060 [
    user-message "It is 2061! End of simulation!"
    stop ]

end

;======================= update the world in each ticks ============================

to print_job

  print word "area_available_for_advanced " area_available_for_advanced
  print word "area_advanced_total " area_advanced_total
  print word "area_taken " area_taken
  print word "area_available_for_advanced " area_available_for_advanced
  print word "join_por_random " [join_por_random] of new_factory 23
  print word "profit_mem_por " [profit_mem_por] of new_factory 23
  print word "capex " [capex] of new_factory 23
  print word "invested_capital_por " [invested_capital_por] of new_factory 23
  print word "join_por? " [join_por?] of new_factory 23
  print word "join_advance? " [join_advance?] of new_factory 23

end

to calculate_kpi

  set sum_new_advanced_por sum [join_por] of new_factories
  set sum_new_advanced sum [join_advance] of new_factories
  ifelse sum_new_advanced > 0
  [
    set sum_new_advance_por_percent ( sum_new_advanced_por / sum_new_advanced ) * 100
  ]
  [
    set sum_new_advance_por_percent 0
  ]

  set sum_converted_industries sum [add_advance] of industries
  set sum_subsidy_onetime sum [subsidy_onetime_here] of new_factories
  set sum_subsidy_perton sum [subsidy_perton] of new_factories * sum [demands] of new_factories * 10


end

to update_por_area

  ;updata advanced biofuel area this year

  ifelse year > 2049
  [set area_available_for_advanced 0]

  [ifelse year > 2039
    [set area_available_for_advanced 0]

    [ifelse year = 2029
      [ifelse area_advanced_total > 400
        [
          set area_taken 0
          set area_available_for_advanced area_available_for_advanced
        ]
        [
          set area_taken 400 - area_advanced_total
          set area_available_for_advanced area_available_for_advanced - area_taken
        ]
      ]

      [ifelse year > 2019
        [set area_available_for_advanced area_available_for_advanced]
        [set area_available_for_advanced 0]]
    ]
  ]

  set_por_open

end

to set_por_open
  ifelse area_available_for_advanced >= area_advanced
  [set por_open? TRUE]
  [set por_open? FALSE]
end


to update_world

  ;time advancement
  set tick_number tick_number + 1.0
  set year year + 1

  ifelse ticks < 31
  [
    set conventional_percent_max item ticks conventional_percent_max_data
    set advanced_percent_min item ticks advanced_percent_min_data
  ]

  [
    set conventional_percent_max conventional_percent_max
    set advanced_percent_min advanced_percent_min
  ]

  ;------------------------------------------------------------------------------------------------------------------------------------------;

  ;update advanced biofuel demands this year
  set advanced_demands_market_por (advanced_demands_market * (por_advanced_market_percentage / 100))
  set advanced_demands_por max ( list ( advanced_demands_market_por + advanced_demands_industries - por_advanced_production) 0)
  set conventional_demands_possibility_por (conventional_demands_possibility * (por_conventional_market_percentage / 100))

  ;------------------------------------------------------------------------------------------------------------------------------------------;

  ;updata advanced biofuel area this year
  update_por_area

  ;------------------------------------------------------------------------------------------------------------------------------------------;

  ;check join year
  set first_join_year_new min ([join_year] of new_factories)
  set first_convert_year_industries min ([join_year] of industries)

  update-plots
  tick-advance 1

end

;======================= technology advancement ============================
to technology_advancement ;done
  set advanced_capex_mem advanced_capex * 1000000

  ; define the state of technology adoption area
  set adoption_weight_scale number_of_new_factories
  set number_of_adopter (sum [join_advance] of new_factories)

  ifelse adoption_weight_scale > 0
  [ set technology_adoption number_of_adopter / adoption_weight_scale]
  [ set technology_adoption 0]


  ; define the state of technology adoption area in Laggards (16%) 84% to 100%
  ifelse technology_adoption > laggards_percent
  [set adoption_phase 5
    set advanced_scale_factor advanced_scale_factor_max
    set advanced_doubling_time advanced_doubling_time_max]
  [   ; define the state of technology adoption area in Late Majority (34%)  50% to 84%
    ifelse technology_adoption > late_majority_percent
    [set adoption_phase 4
      set advanced_scale_factor advanced_scale_factor_min * 1.2
      set advanced_doubling_time advanced_doubling_time_min]
    [   ; define the state of technology adoption area in Early Majority (34%) 16% 16% to 50%
      ifelse technology_adoption > early_majority_percent
      [set adoption_phase 3
        set advanced_scale_factor advanced_scale_factor_min
        set advanced_doubling_time advanced_doubling_time_min + 1]
      [   ; define the state of technology adoption area in Early Adopters (13.5%)  2.5% to 16%
        ifelse technology_adoption > early_adopter_percent
        [set adoption_phase 2
          set advanced_scale_factor advanced_scale_factor_min * 1.2
          set advanced_doubling_time advanced_doubling_time_max]
        [   ; define the state of technology adoption area in Innovators (2.5%) 0% to 2.5%
          set adoption_phase 1
          set advanced_scale_factor advanced_scale_factor_max
          set advanced_doubling_time advanced_doubling_time_max * 2 ]]]]

  ;technology advancement changes CAPEX, OPEX, and capacity of biofuel facility based on adoption_phase
  ifelse advanced_capacity < advanced_capacity_max
  [set advanced_capacity_factor (e ^ (ln(2) * 1.0 /  advanced_doubling_time))]
  [set advanced_capacity_factor 1.0 ] ; technology has goes stagnant

  set advanced_capacity advanced_capacity * advanced_capacity_factor

  ifelse (advanced_capex_mem / (max (list advanced_capacity 1))) > 250.0
  [set advanced_capex_factor (advanced_capacity_factor) ^ advanced_scale_factor]
  [set advanced_capex_factor 1.0] ; technology has goes stagnant


  ifelse advanced_opex > advanced_opex_min
  [set advanced_opex_factor advanced_capex_factor / advanced_capacity_factor]
  [set advanced_opex_factor 1.0]  ; technology has goes stagnant
  set advanced_opex advanced_opex  * advanced_opex_factor

  ;technology advancement changes CAPEX, OPEX, and capacity of biofuel facility based on adoption_phase in upgrading bussiness
  ifelse upgrade_capacity < upgrade_capacity_max
  [set upgrade_capacity_factor (e ^ (ln(2) * 1.0 /  advanced_doubling_time ))]
  [set upgrade_capacity_factor 1.0 ] ; technology has goes stagnant

  set upgrade_capacity upgrade_capacity * upgrade_capacity_factor

  ifelse (upgrade_capex_mem / upgrade_capacity) > 200.0
  [set upgrade_capex_factor (upgrade_capacity_factor) ^ advanced_scale_factor]
  [set upgrade_capex_factor 1.0] ; technology has goes stagnant

  ;------------------ capacity --------------------
  set advanced_capacity_1 advanced_capacity_1_percent * advanced_capacity
  set advanced_capacity_2 advanced_capacity_2_percent * advanced_capacity
  set advanced_capacity_3 advanced_capacity_3_percent * advanced_capacity
  set advanced_capacity_4 advanced_capacity_4_percent * advanced_capacity
  set advanced_capacity_5 advanced_capacity_5_percent * advanced_capacity

  ;------------------ capex --------------------`
  set advanced_capex_1  advanced_capex_1 * advanced_capex_factor
  set advanced_capex_2 advanced_capex_2 * advanced_capex_factor
  set advanced_capex_3 advanced_capex_3 * advanced_capex_factor
  set advanced_capex_4 advanced_capex_4 * advanced_capex_factor
  set advanced_capex_5 advanced_capex_5 * advanced_capex_factor
  set advanced_capex_mem advanced_capex_mem * advanced_capex_factor

  ;------------------ opex --------------------`
  set advanced_opex_1 advanced_opex_1_percent * advanced_opex
  set advanced_opex_2 advanced_opex_2_percent * advanced_opex
  set advanced_opex_3 advanced_opex_3_percent * advanced_opex
  set advanced_opex_4 advanced_opex_4_percent * advanced_opex
  set advanced_opex_5 advanced_opex_5_percent * advanced_opex

  ;------------------ capacity upgrade --------------------
  set upgrade_capacity_1 upgrade_capacity_1_percent * upgrade_capacity
  set upgrade_capacity_2 upgrade_capacity_2_percent * upgrade_capacity
  set upgrade_capacity_3 upgrade_capacity_3_percent * upgrade_capacity
  set upgrade_capacity_4 upgrade_capacity_4_percent * upgrade_capacity

  ;------------------ capex upgrade--------------------`
  set upgrade_capex_1  upgrade_capex_1 * upgrade_capex_factor
  set upgrade_capex_2 upgrade_capex_2 * upgrade_capex_factor
  set upgrade_capex_3 upgrade_capex_3 * upgrade_capex_factor
  set upgrade_capex_4 upgrade_capex_4 * upgrade_capex_factor
  set upgrade_capex_mem upgrade_capex_mem * upgrade_capex_factor

  ;======================= technology advancement end ============================


  ;------------------------------------------------------------------------------------------------------------------------------------------;
end

;======================= calculate advanced biofuel demands ============================
to sum_por_demands
  ;internal production

  set por_oil_production sum [oil_production] of industries
  set por_conventional_production sum [conventional_production] of industries
  set por_advanced_production_industries sum [advanced_production] of industries

   ;demands changes over time ;advanced biofuel demannds from industries + from market
  set advanced_demands_industries sum [advanced_demands] of industries

  set por_advanced_production (por_advanced_production_industries + por_advanced_production_new)
  set market_new_advanced_production sum [production] of new_factories
  set market_advanced_production por_advanced_production + market_new_advanced_production

end

;======================= calculate advanced biofuel market demands ============================
to market_demands

  ;------------------------------------------------------------------------------------------------------------------------------------------;
  ifelse advanced_feedstock_prices_pes < advanced_feedstock_prices_max
  ;set the advanced biofuel feestock price between optimist and pesimist

  [set advanced_feedstock_prices_opt advanced_feedstock_prices_opt * (1 + (advanced_feedstock_prices_increase / 100))
    set advanced_feedstock_prices_pes advanced_feedstock_prices_pes * (1 + (advanced_feedstock_prices_increase / 100))
    set advanced_feedstock_prices advanced_feedstock_prices_opt + (random (advanced_feedstock_prices_pes - advanced_feedstock_prices_opt))]
  [set advanced_feedstock_prices_opt advanced_feedstock_prices_opt
    set advanced_feedstock_prices_pes advanced_feedstock_prices_pes
    set advanced_feedstock_prices advanced_feedstock_prices]

  ;update oil demands in the market this year
  set oil_demands_market (oil_demands_market * (1 + (oil_demands_market_increase - efficiency_effect) / 100))

  ;advanced market demands this year

  ifelse advanced_prices > (advanced_counting * conventional_prices)
    [
      set conventional_demands_market (oil_demands_market * (conventional_percent_max / 100))
      set advanced_demands_market (oil_demands_market * ((biofuel_percent_min / 100) - (conventional_percent_max / 100)) / advanced_counting ) - market_advanced_production
  ]
    [
    set biofuel_demands_market (oil_demands_market * ((biofuel_percent_min / 100) / advanced_counting))
    set advanced_demands_market biofuel_demands_market - market_advanced_production
    set conventional_demands_market 0.0
  ]

  ;conventional market possibility this year
  set conventional_demands_possibility (oil_demands_market * (conventional_percent_max / 100))


  ;price changes over time
  ;oil prices oil_prices < oil_prices_max
  ifelse oil_prices < oil_prices_max
  [
    set oil_prices oil_prices * (1.0 + (oil_prices_increase / 100))
  ]
  [
    set oil_prices oil_prices_max
  ]

  ;conventional biofuel prices

  ifelse conventional_prices < conventional_prices_max
  [
    set conventional_prices conventional_prices * (1.0 + (conventional_prices_increase / 100))
  ]
  [
    set conventional_prices conventional_prices_max
  ]

  ;advanced biofuel prices

  ifelse advanced_prices < advanced_prices_max
    [
      set advanced_prices advanced_prices * (1.0 + (advanced_prices_increase / 100))
  ]
  [
    set advanced_prices advanced_prices_max
  ]

end

;======================= calculate weighted average cost of capital (wacc) this year ============================
to set_wacc ;setup done, code done, tested

  ifelse wacc_min > wacc_conventional_min
  [
    set wacc_min wacc_min * ( 1.0 - wacc_rate )
  ]
  [
    set wacc_min wacc_conventional_min
  ]

  ifelse wacc_max > wacc_conventional_max
  [
    set wacc_max wacc_max * ( 1.0 - wacc_rate)
  ]
  [
    set wacc_max wacc_conventional_max
  ]

end

;======================= new factories decide to join advanced biofuel ============================
to join_advanced_por

  ifelse (area_available_for_advanced >= area_advanced) ;check of por still have avaiable space
  [
    set join_por? TRUE
    set join_por 1
    set join_year year
    set area_advanced_total area_advanced_total + area_advanced
    set area_available_for_advanced area_available_for_advanced - area_advanced
    set por_advanced_production_new (por_advanced_production_new + demands)
    set production demands
    set not_por? FALSE

    set por_subsidy_budget por_subsidy_budget + (subsidy_onetime_here) + (subsidy_perton * demands * 10) ;for the first 5 years

    set shape "factory"
    set color grey
    set size 3
    set label-color green
    setxy random-pxcor random-pycor

    set_por_open
  ]

  [join_advanced_other]

end

to join_advanced_other

  set join_por? FALSE
  set join_por 0
  set join_year join_year
  set area_advanced_total area_advanced_total
  set area_available_for_advanced area_available_for_advanced

  set por_advanced_production_new por_advanced_production_new
  set production demands

  set not_por? TRUE

end

to keep_advanced_state

  set join_por? join_por?
  set join_por join_por
  set join_year join_year
  set area_advanced_total area_advanced_total
  set por_advanced_production_new por_advanced_production_new
  set not_por? not_por?

end

to join_advanced_new


  ask new_factories [
    ;execute procedure if the industries has not join biofuel facility

    set join_por_random random 100;

          ;see if internal demands still exist, add probability if inside demands still exist
      ifelse advanced_demands_por > demands_mem
    [
      set reduced_risk_percent PoR_connection_reduced_risk
      set extra_possibility_percent 0
    ]
    [
      set reduced_risk_percent 0
      set extra_possibility_percent 2
    ]

    ifelse (join_advance? = FALSE)
    [
      set join_por? FALSE
      ;init: set new variable this year
      set availability (random 20.0 + 80.0 ) / 100.0
      set wacc (( random (wacc_max - wacc_min)) + wacc_min )
      set capacity_mem advanced_capacity_min + random (advanced_capacity - advanced_capacity_min)

      ;===================== set category =====================
      ;characterize companies based on their capacity capability
      ;set category 1, high capacity
      ifelse capacity_mem > advanced_capacity_2
      [set category 1
        set capex advanced_capex_1
        set opex advanced_opex_1
        set capacity advanced_capacity_1]
      [
        ;set category 2, medium high capacity
        ifelse capacity_mem > advanced_capacity_3
        [set category 2
          set capex advanced_capex_2
          set opex advanced_opex_2
          set capacity advanced_capacity_2]

        [
          ;set category 3, medium capacity
          ifelse capacity_mem > advanced_capacity_4
          [set category 3
            set capex advanced_capex_3
            set opex advanced_opex_3
            set capacity advanced_capacity_3]
          [
            ;set category 4, medium low capacity
            ifelse capacity_mem > advanced_capacity_5
            [set category 4
              set capex advanced_capex_4
              set opex advanced_opex_4
              set capacity advanced_capacity_4]

            [
              ;set category 5, low capacity
              set category 5
              set capex advanced_capex_5
              set opex advanced_opex_5
              set capacity advanced_capacity_5]]]]

      ;===================== set category fin =====================

      ;1. Calculate the amount of advanced biofuel that can be produced each year based on the market demands
      set demands_mem availability * capacity

      ifelse advanced_demands_market > demands_mem
      [
        set demands demands_mem
      ]
      [
        set demands advanced_demands_por
      ]
      ;2. Profit of selling
      set feedstock_prices_mem (advanced_feedstock_prices * (1 + advanced_feedstock_dues))

      set profit_mem ((advanced_prices - opex - feedstock_prices_mem))
      set profit_mem_por ((advanced_prices + subsidy_perton - opex - feedstock_prices_mem))

      set profit profit_mem * (1.0 - tax) * demands
      set profit_por profit_mem_por * (1.0 - tax) * demands

      ;3. Calculate the amount of roic

      ifelse subsidy_onetime < capex
      [set subsidy_onetime_here subsidy_onetime]
      [set subsidy_onetime_here capex - 1]

      set invested_capital_por capex - subsidy_onetime_here

      set roic_por ((profit_por / invested_capital_por) + (reduced_risk_percent / 100));
      set roic profit / capex

      ;4. set wacc based on reduced risk
      set min_roic wacc / 100;

      ;5. Decide to make biofuel plan or not

      ;if roic is more than min roic, then the company will make the factory

      ;if roic of por is more than roic absolut, then the company will join POR

      ifelse roic > min_roic
      [

        set join_advance? TRUE
        set join_advance 1.0

        set roic_absolut ( ( 1 + ( (join_por_random / 100) * 0.25 ) ) * roic)
        ifelse roic_por > roic_absolut ;if it is really good to go to POR compared to other place
        [
          join_advanced_por
        ]
        [
          ifelse (join_por_random < join_pora_percent + extra_possibility_percent)
          [ join_advanced_por  ]
          [ join_advanced_other ]
        ]
      ]

      ;if roic is less than min roic, then the company will choose randomly
      [
        keep_advanced_state
      ]

      ;end ofL if new have not join advanced biofuel facility
    ]

    ;if they already join advanced biofuel facility
    [
      ifelse (join_por? = FALSE)

      [
        ;keep last condition
        keep_advanced_state
      ]
        [
        ;wait for 4 years till the company is built
        ifelse year > join_year + 4
        [set color green]
        [set color grey]
      ]
    ]

  ]
end

;======================= incumbent industries decide to buy advanced biofuel ============================
to buy_biofuel

  ask industries
  [ set availability ((random 20.0 + 80.0 ) / 100.0 )
    set oil_production oil_production_input * availability

    ifelse oil_production > 0.0
    [

      ifelse advanced_prices > (advanced_counting * conventional_prices)
      [
        set conventional_demands (oil_production * (conventional_percent_max  / 100))

        set advanced_demands_s1 (oil_production * ((biofuel_percent_min / 100) - (conventional_percent_max / 100)) / advanced_counting )
        set advanced_demands_s2 (oil_production * (advanced_percent_min / 100))

        ifelse advanced_demands_s1 > advanced_demands_s2 ;pick the biggest of between advanced demands
        [set advanced_demands advanced_demands_s1]
        [set advanced_demands advanced_demands_s2]

        set biofuel_demands (advanced_demands + conventional_demands)
      ]

      ;if advanced biofuel is cheaper, buy all advanced biofuel
      [
        set biofuel_demands (oil_production * ((biofuel_percent_min / 100) / advanced_counting))
        set advanced_demands biofuel_demands
        set conventional_demands 0.0
      ]
    ]
    [
      set conventional_demands 0.0
      set advanced_demands 0.0
    ]
  ]
end

;======================= incumbent industries decide to create advanced biofuel ============================
to change_biofuel

  ;set industries turn to check their possibility to go advanced biofuel
  ;based on game theory, that one actor action will influence the other actors actions
  ;ifelse industry_turn < number_of_biofuel_companies
  ;[set industry_turn industry_turn + 1]
  ;[set industry_turn 0]


  ifelse (conventional_demands_possibility_por < por_conventional_production) AND (advanced_demands_por > 0)
  ;if international demands is low, change productions
  [ ask one-of industries with [conventional_production > 0] [
    ;----------------check roic---------------
    ifelse (conventional_production > 0)
    [ ;init: set new variable this year
      set availability ((random 20.0 + 80.0 ) / 100.0 )
      set wacc (( random (wacc_max - wacc_min)) + wacc_min )
      set capacity_mem conventional_production

      ;===================== set category =====================
      ;characterize companies based on their capacity capability and their production capacity

      ;set category 1, high capacity
      ifelse capacity_mem > upgrade_capacity_2
      [set category 1
        set capex upgrade_capex_1
        set opex advanced_opex_2
        set capacity upgrade_capacity_1]
      [
        ;set category 2, medium high capacity
        ifelse capacity_mem > upgrade_capacity_3
        [set category 2
          set capex upgrade_capex_2
          set opex advanced_opex_3
          set capacity upgrade_capacity_2]

        [
          ;set category 3, medium capacity
          ifelse capacity_mem > upgrade_capacity_4
          [set category 3
            set capex upgrade_capex_3
            set opex advanced_opex_4
            set capacity upgrade_capacity_3]

          [
            ;set category 4, medium low capacity
            set category 4
            set capex upgrade_capex_4
              set opex advanced_opex_5
            set capacity upgrade_capacity_4]]]

     ;===================== set category fin =====================

      ;1. Calculate the amount of advanced biofuel that can be produced each year based on the market demand
      ifelse capacity_mem > capacity ;if the capacity they want is more than the capacity they have, choose capacity
      [ set demands capacity ]
      [ set demands capacity_mem ]

      ;2. Profit of selling

      set feedstock_prices_mem (advanced_feedstock_prices * (1 + advanced_feedstock_dues))
      set profit_mem ((advanced_prices + 0 - opex - feedstock_prices_mem))
      set profit profit_mem * (1.0 - tax) * demands * availability

      ;3. Calculate the amount of roic
      set invested_capital capex + 1
      set roic profit / invested_capital

      ;4. set wacc based on reduced risk
      set reduced_risk_percent 0
      set min_roic (wacc) / 100;

      ;5. Decide to make biofuel plan or not
      ifelse roic > min_roic
      [
        set advanced_production (advanced_production + demands)
        set conventional_production (conventional_production - demands)
        set add_advance 1.0
        set add_advance? TRUE
        set join_year year
        set color green
      ]
      [
        set advanced_production advanced_production
        set conventional_production conventional_production
        set add_advance 0.0
        set add_advance? FALSE
        set join_year join_year
      ]]

    ;    ifelse (conventional_production > 0) else case
    [set conventional_production conventional_production
      set advanced_production advanced_production]
    ]

  ]

  ;if international demands is high, keep on producing conventional
  [ask industries [
    set add_advance? add_advance?
    set add_advance add_advance
    ]
  ]

end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; READ PROCEDURES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;======================= read companies data ============================
to read_industry ;done
  file-close-all ;Close all open files

  if not file-exists? "companies_data.csv" [
    user-message "No file 'companies_data.csv' exists!"
    stop
  ]

  file-open "companies_data.csv" ;Open the file with the CO2 price data

  ;We'll read all the data in a single loop
  while [ not file-at-end? ] [
    ;Here the CSV extension grabs a single line and puts the read data in a list
    set companies_data csv:from-row file-read-line
    set companies_label lput item 1 companies_data companies_label
    set conventional_production_industries lput item 2 companies_data conventional_production_industries
    set oil_production_industries lput item 3 companies_data oil_production_industries

    ;Now we can use that list to create a turtle with the saved properties
  ]
  set companies_label remove-item 0 companies_label
  set oil_production_industries remove-item 0 oil_production_industries
  set conventional_production_industries remove-item 0 conventional_production_industries
  file-close ;Close the file
end

to read_redii ;done
  file-close-all ;Close all open files

  if not file-exists? "red_data.csv" [
    user-message "No file 'red_data.csv' exists!"
    stop
  ]

  file-open "red_data.csv" ;Open the file with the CO2 price data

  ;We'll read all the data in a single loop
  while [ not file-at-end? ] [
    ;Here the CSV extension grabs a single line and puts the read data in a list
    set red_data csv:from-row file-read-line
    set conventional_percent_max_data lput item 1 red_data conventional_percent_max_data
    set advanced_percent_min_data lput item 2 red_data advanced_percent_min_data
    ;Now we can use that list to create a turtle with the saved properties
  ]
  set conventional_percent_max_data remove-item 0 conventional_percent_max_data
  set advanced_percent_min_data remove-item 0 advanced_percent_min_data

  file-close ;Close the file
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; UI SETTING PROCEDURES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@#$#@#$#@
GRAPHICS-WINDOW
295
60
1148
472
-1
-1
13.0
1
10
1
1
1
0
1
1
1
-32
32
-15
15
0
0
1
ticks
30.0

SLIDER
10
480
262
513
wacc_min
wacc_min
0
50
6.3
1
1
%
HORIZONTAL

SLIDER
10
514
263
547
wacc_max
wacc_max
0
50
12.8
1
1
%
HORIZONTAL

BUTTON
110
55
173
88
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
180
55
240
88
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
180
90
240
123
NIL
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
20
20
170
39
Commands
15
102.0
1

TEXTBOX
292
6
442
26
Port Of Rotterdam
15
102.0
1

TEXTBOX
10
155
160
174
World Setting
15
102.0
1

TEXTBOX
17
361
167
379
New Companies
11
0.0
1

TEXTBOX
14
180
164
198
Port Of Rotterdam
11
0.0
1

SLIDER
10
200
255
233
PoR_connection_reduced_risk
PoR_connection_reduced_risk
0
5
0.5
1
1
%
HORIZONTAL

SLIDER
10
376
263
409
availability_input
availability_input
0
100
90.0
1
1
%
HORIZONTAL

TEXTBOX
30
945
180
963
Market
11
0.0
1

MONITOR
45
90
170
135
NIL
year
17
1
11

TEXTBOX
15
670
165
688
Government
11
0.0
1

SLIDER
11
688
264
721
advanced_counting
advanced_counting
0
10
2.0
1
1
NIL
HORIZONTAL

SLIDER
10
550
263
583
wacc_rate
wacc_rate
0
100
0.03
1
1
NIL
HORIZONTAL

SLIDER
15
795
275
828
advanced_capex
advanced_capex
0
3000
1000.0
1
1
M€/ton/year 
HORIZONTAL

SLIDER
15
830
275
863
advanced_capacity
advanced_capacity
0
12000000
1.0396830673359793E7
1
1
ton/year 
HORIZONTAL

SLIDER
15
865
275
898
advanced_opex
advanced_opex
0
300
42.744569873335095
0.1
1
€/ton
HORIZONTAL

SLIDER
5
970
266
1003
por_advanced_market_percentage
por_advanced_market_percentage
0
100
0.03
5
1
%
HORIZONTAL

SLIDER
5
1235
265
1268
oil_demands_market
oil_demands_market
0
1000000000000
2.700618496371004E11
1
1
liter/year
HORIZONTAL

SLIDER
5
1270
265
1303
oil_demands_market_increase
oil_demands_market_increase
0
100
-0.25
1
1
%
HORIZONTAL

SLIDER
14
900
273
933
efficiency_effect
efficiency_effect
0
100
0.0
1
1
%
HORIZONTAL

SLIDER
5
1135
265
1168
advanced_prices
advanced_prices
advanced_prices_min
advanced_prices_max
1835.4766207551038
0.1
1
€/liter 
HORIZONTAL

SLIDER
5
1340
266
1373
advanced_prices_increase
advanced_prices_increase
0
100
0.1
1
1
%
HORIZONTAL

SLIDER
4
1169
264
1202
oil_prices
oil_prices
oil_prices_min
oil_prices_max
2408.8508205841185
0.01
1
€/liter
HORIZONTAL

SLIDER
6
1375
266
1408
oil_prices_increase
oil_prices_increase
0
100
0.75
1
1
%
HORIZONTAL

SLIDER
5
1202
263
1235
conventional_prices
conventional_prices
conventional_prices_min
conventional_prices_max
1767.4272579969434
0.1
1
€/liter 
HORIZONTAL

SLIDER
3
1306
263
1339
advanced_feedstock_prices_increase
advanced_feedstock_prices_increase
0
100
1.0
1
1
%
HORIZONTAL

SLIDER
6
1408
266
1441
conventional_prices_increase
conventional_prices_increase
0
100
0.01
1
1
%
HORIZONTAL

SLIDER
10
235
255
268
subsidy_perton
subsidy_perton
0
2000
0.0
1
1
€/ton
HORIZONTAL

SLIDER
11
721
263
754
tax
tax
0
100
0.0
1
1
%
HORIZONTAL

SLIDER
10
270
255
303
subsidy_onetime
subsidy_onetime
0
1000000000
0.0
1
1
€ 
HORIZONTAL

SLIDER
9
444
262
477
join_pora_percent
join_pora_percent
0
100
5.0
1
1
%
HORIZONTAL

SLIDER
11
586
263
619
wacc_conventional_min
wacc_conventional_min
0
100
6.3
1
1
% 
HORIZONTAL

SLIDER
11
621
264
654
wacc_conventional_max
wacc_conventional_max
0
100
12.8
1
1
%
HORIZONTAL

TEXTBOX
20
774
170
792
Technology
11
0.0
1

MONITOR
295
426
367
471
NIL
por_open?
17
1
11

PLOT
295
479
626
649
WACC
Year
%
0.0
30.0
0.0
32.0
true
true
"" ""
PENS
"Min" 1.0 0 -5298144 true "" "plot wacc_max"
"Max" 1.0 0 -15040220 true "" "plot wacc_min"

SLIDER
4
1095
296
1128
advanced_feedstock_prices_pes_init
advanced_feedstock_prices_pes_init
0
2000
750.0
1
1
€/ton
HORIZONTAL

SLIDER
5
1061
297
1094
advanced_feedstock_prices_opt_init
advanced_feedstock_prices_opt_init
0
2000
520.0
1
1
€/ton
HORIZONTAL

MONITOR
295
1280
550
1325
NIL
oil_demands_market
17
1
11

SLIDER
9
410
263
443
number_of_new_factories
number_of_new_factories
0
200
100.0
1
1
NIL
HORIZONTAL

MONITOR
425
10
560
55
NIL
sum_new_advanced_por
17
1
11

MONITOR
565
10
685
55
NIL
sum_new_advanced
17
1
11

PLOT
630
481
910
651
RED II
Year
%
0.0
33.0
0.0
10.0
true
true
"" ""
PENS
"advance min" 1.0 0 -16777216 true "" "plot advanced_percent_min"
"conventional max" 1.0 0 -7500403 true "" "plot conventional_percent_max"

PLOT
295
656
625
806
Conventional  (MTon)
NIL
NIL
0.0
6.0
0.0
6.0
true
true
"" ""
PENS
"Demands" 1.0 0 -16777216 true "" "plot conventional_demands_possibility_por / 1000000"
"Production" 1.0 0 -10402772 true "" "plot por_conventional_production / 1000000"

SLIDER
5
1010
269
1043
por_conventional_market_percentage
por_conventional_market_percentage
0
100
0.005
1
1
%
HORIZONTAL

PLOT
630
657
910
807
Advanced Capacity Scale (MTon)
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Maximum" 1.0 0 -16777216 true "" "plot advanced_capacity_1 / 1000000"
"High" 1.0 0 -7500403 true "" "plot advanced_capacity_2 / 1000000"
"Medium" 1.0 0 -2674135 true "" "plot advanced_capacity_3 / 1000000"
"Low" 1.0 0 -955883 true "" "plot advanced_capacity_4 / 1000000"
"Minimum" 1.0 0 -6459832 true "" "plot advanced_capacity_5 / 1000000"

PLOT
295
811
625
961
Advanced Demands (MTon)
NIL
NIL
0.0
5.0
0.0
5.0
true
true
"" ""
PENS
"Market" 1.0 0 -16777216 true "" "plot advanced_demands_market_por / 1000000"
"Inside" 1.0 0 -13840069 true "" "plot advanced_demands_industries / 1000000"

PLOT
295
966
625
1116
Advanced Production (MTon)
NIL
NIL
0.0
3.0
0.0
3.0
true
true
"" ""
PENS
"Produced" 1.0 0 -16777216 true "" "plot por_advanced_production / 1000000 "
"Converted" 1.0 0 -7500403 true "" "plot por_advanced_production_industries / 1000000"
"New" 1.0 0 -2674135 true "" "plot por_advanced_production_new / 1000000"
"Demands" 1.0 0 -955883 true "" "plot advanced_demands_por / 1000000"

PLOT
630
812
910
962
Capex Scale (Eur/MTon/Year)
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Minimum" 1.0 0 -16777216 true "" "plot advanced_capex_1 / advanced_capacity_1"
"Low" 1.0 0 -7500403 true "" "plot advanced_capex_2 / advanced_capacity_2"
"Medium" 1.0 0 -2674135 true "" "plot advanced_capex_3 / advanced_capacity_3"
"High" 1.0 0 -955883 true "" "plot advanced_capex_4 / advanced_capacity_4"
"Maximum" 1.0 0 -6459832 true "" "plot advanced_capex_5 / advanced_capacity_5"

PLOT
915
480
1220
650
Adoption Phase
NIL
NIL
0.0
1.0
0.0
1.0
true
true
"" ""
PENS
"Adoption" 1.0 0 -16777216 true "" "plot technology_adoption * 5"
"Laggard" 1.0 0 -7500403 true "" "plot laggards_percent * 5"
"Late" 1.0 0 -2674135 true "" "plot late_majority_percent * 5"
"Majority" 1.0 0 -955883 true "" "plot early_majority_percent * 5"
"Early" 1.0 0 -6459832 true "" "plot early_adopter_percent * 5"
"Innovator" 1.0 0 -1184463 true "" "plot innovator_percent * 5"
"Phase" 1.0 0 -10899396 true "" "plot adoption_phase"

MONITOR
690
10
835
55
NIL
sum_converted_industries
17
1
11

PLOT
915
655
1220
805
Area
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Available" 1.0 0 -16777216 true "" "plot area_available_for_advanced"
"Used" 1.0 0 -7500403 true "" "Plot area_advanced_total"
"Initial" 1.0 0 -2674135 true "" "plot initial_area_advanced"
"Taken" 1.0 0 -955883 true "" "plot area_taken"

PLOT
915
810
1220
960
Advanced Feedstock Price (Eur/Ton)
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Current" 1.0 0 -16777216 true "" "plot advanced_feedstock_prices"
"Optimist" 1.0 0 -7500403 true "" "plot advanced_feedstock_prices_opt"
"Pesimist" 1.0 0 -2674135 true "" "plot advanced_feedstock_prices_pes"

PLOT
915
965
1220
1115
Fuel Price (Eur/Ton)
NIL
NIL
0.0
10.0
1500.0
2500.0
true
true
"" ""
PENS
"Advanced" 1.0 0 -16777216 true "" "plot advanced_prices"
"Conventional" 1.0 0 -7500403 true "" "plot conventional_prices"
"Oil" 1.0 0 -2674135 true "" "plot oil_prices"

PLOT
630
965
910
1115
OPEX Scale (Eur/Ton/Year)
NIL
NIL
0.0
1.0
0.0
1.0
true
true
"" ""
PENS
"Minimum" 1.0 0 -16777216 true "" "plot advanced_opex_1"
"Low" 1.0 0 -7500403 true "" "plot advanced_opex_2"
"Medium" 1.0 0 -2674135 true "" "plot advanced_opex_3 "
"High" 1.0 0 -955883 true "" "plot advanced_opex_4"
"Maximum" 1.0 0 -6459832 true "" "plot advanced_opex_5"

PLOT
630
1120
910
1270
Join Advanced POR
NIL
NIL
0.0
5.0
0.0
5.0
true
true
"" ""
PENS
"New" 1.0 0 -16777216 true "" "plot sum [join_por] of new_factories"
"Converted" 1.0 0 -2674135 true "" "plot sum [add_advance] of industries"
"Total" 1.0 0 -7500403 true "" "plot sum [join_por] of new_factories + sum [add_advance] of industries"

PLOT
920
1120
1220
1270
Join Advanced All (New)
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot sum [join_advance] of new_factories"

SLIDER
10
305
255
338
area_advanced
area_advanced
0
250
50.0
1
1
m2
HORIZONTAL

PLOT
295
1120
625
1270
Subsidy
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"Total" 1.0 0 -16777216 true "" "plot por_subsidy_budget"
"Onetime" 1.0 0 -7500403 true "" "plot sum_subsidy_onetime"
"Perton" 1.0 0 -2674135 true "" "plot sum_subsidy_perton"

PLOT
630
1275
910
1425
Oil Demands (Gton)
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot oil_demands_market / 1000000000"

PLOT
920
1275
1220
1425
Biofuel Demands (Gton)
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Advanced" 1.0 0 -16777216 true "" "plot advanced_demands_market / 1000000000"
"Conventional" 1.0 0 -7500403 true "" "plot conventional_demands_market / 1000000000"

BUTTON
45
55
105
88
init
setup_optional
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
840
10
972
55
NIL
initial_area_advanced
17
1
11

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

factory
false
0
Rectangle -7500403 true true 76 194 285 270
Rectangle -7500403 true true 36 95 59 231
Rectangle -16777216 true false 90 210 270 240
Line -7500403 true 90 195 90 255
Line -7500403 true 120 195 120 255
Line -7500403 true 150 195 150 240
Line -7500403 true 180 195 180 255
Line -7500403 true 210 210 210 240
Line -7500403 true 240 210 240 240
Line -7500403 true 90 225 270 225
Circle -1 true false 37 73 32
Circle -1 true false 55 38 54
Circle -1 true false 96 21 42
Circle -1 true false 105 40 32
Circle -1 true false 129 19 42
Rectangle -7500403 true true 14 228 78 270

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0.4
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="experiment pesimist" repetitions="100" runMetricsEveryStep="false">
    <setup>setup_experiment_seed
setup</setup>
    <go>go</go>
    <timeLimit steps="32"/>
    <metric>por_advanced_production</metric>
    <metric>por_conventional_production</metric>
    <metric>por_advanced_production_industries</metric>
    <metric>por_advanced_production_new</metric>
    <metric>por_subsidy_budget</metric>
    <metric>area_advanced_total</metric>
    <metric>area_taken</metric>
    <metric>first_join_year_new</metric>
    <metric>first_convert_year_industries</metric>
    <metric>sum_new_advanced_por</metric>
    <metric>sum_new_advanced</metric>
    <metric>sum_new_advance_por_percent</metric>
    <metric>sum_converted_industries</metric>
    <metric>sum_subsidy_onetime</metric>
    <metric>sum_subsidy_perton</metric>
    <metric>market_new_advanced_production</metric>
    <metric>market_advanced_production</metric>
    <enumeratedValueSet variable="wacc_conventional_min">
      <value value="6.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="tax">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="advanced_capacity">
      <value value="800000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PoR_connection_reduced_risk">
      <value value="0"/>
      <value value="0.5"/>
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="wacc_rate">
      <value value="0.03"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="advanced_prices">
      <value value="1760"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="subsidy_onetime">
      <value value="0"/>
      <value value="1000000"/>
      <value value="10000000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="wacc_conventional_max">
      <value value="12.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="oil_prices">
      <value value="1760.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="por_conventional_market_percentage">
      <value value="0.005"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="subsidy_perton">
      <value value="0"/>
      <value value="450"/>
      <value value="900"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="advanced_capex">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="por_advanced_market_percentage">
      <value value="0.03"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="conventional_prices">
      <value value="1760.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="area_advanced">
      <value value="0"/>
      <value value="50"/>
      <value value="250"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="wacc_min">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="advanced_feedstock_prices_opt">
      <value value="750"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_area_advanced">
      <value value="750"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="availability_input">
      <value value="90"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="advanced_feedstock_prices_increase">
      <value value="-5"/>
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="wacc_max">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="join_pora_percent">
      <value value="3"/>
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="advanced_feedstock_prices_pes">
      <value value="760"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="oil_demands_market">
      <value value="300000000000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="oil_prices_increase">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="oil_demands_market_increase">
      <value value="-0.25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number_of_new_factories">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="advanced_opex">
      <value value="132.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="advanced_counting">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="efficiency_effect">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="conventional_prices_increase">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="advanced_prices_increase">
      <value value="-5"/>
      <value value="5"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment optimist" repetitions="100" runMetricsEveryStep="false">
    <setup>setup_experiment_seed
setup</setup>
    <go>go</go>
    <timeLimit steps="32"/>
    <metric>por_advanced_production</metric>
    <metric>por_conventional_production</metric>
    <metric>por_advanced_production_industries</metric>
    <metric>por_advanced_production_new</metric>
    <metric>por_subsidy_budget</metric>
    <metric>area_advanced_total</metric>
    <metric>area_taken</metric>
    <metric>first_join_year_new</metric>
    <metric>first_convert_year_industries</metric>
    <metric>sum_new_advanced_por</metric>
    <metric>sum_new_advanced</metric>
    <metric>sum_new_advance_por_percent</metric>
    <metric>sum_converted_industries</metric>
    <metric>sum_subsidy_onetime</metric>
    <metric>sum_subsidy_perton</metric>
    <metric>market_new_advanced_production</metric>
    <metric>market_advanced_production</metric>
    <enumeratedValueSet variable="wacc_conventional_min">
      <value value="6.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="tax">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="advanced_capacity">
      <value value="800000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="PoR_connection_reduced_risk">
      <value value="0"/>
      <value value="0.5"/>
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="wacc_rate">
      <value value="0.03"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="advanced_prices">
      <value value="1760"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="subsidy_onetime">
      <value value="0"/>
      <value value="1000000"/>
      <value value="10000000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="wacc_conventional_max">
      <value value="12.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="oil_prices">
      <value value="1760.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="por_conventional_market_percentage">
      <value value="0.005"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="subsidy_perton">
      <value value="0"/>
      <value value="450"/>
      <value value="900"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="advanced_capex">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="por_advanced_market_percentage">
      <value value="0.03"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="conventional_prices">
      <value value="1760.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="area_advanced">
      <value value="0"/>
      <value value="50"/>
      <value value="250"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="wacc_min">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="advanced_feedstock_prices_opt">
      <value value="510"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_area_advanced">
      <value value="750"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="availability_input">
      <value value="90"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="advanced_feedstock_prices_increase">
      <value value="-5"/>
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="wacc_max">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="join_pora_percent">
      <value value="3"/>
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="advanced_feedstock_prices_pes">
      <value value="520"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="oil_demands_market">
      <value value="300000000000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="oil_prices_increase">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="oil_demands_market_increase">
      <value value="-0.25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number_of_new_factories">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="advanced_opex">
      <value value="132.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="advanced_counting">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="efficiency_effect">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="conventional_prices_increase">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="advanced_prices_increase">
      <value value="-5"/>
      <value value="5"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
1
@#$#@#$#@
