# WHAT IS IT?

An alternative implementation of the NetLogo model 'State Machine Example'. Use an external JSON file to define the bugs' statechart, and imported into a turtles-own statechart (a netlogo table or dictionary).

# HOW IT WORKS

A state machine consists of state names, state behaviors, and transitions between states. We use key "name" to refer state name, key "action" to refer behaviors, and key "transfer_conditions" to refer transition rules.

# profiler test


observer> profiler:start
observer> repeat 10000 [ go ] profiler:stop print profiler:report
BEGIN PROFILING DUMP
Sorted by Exclusive Time
Name                               Calls Incl T(ms) Excl T(ms) Excl/calls
COPIED_TABLE_OF                  1314299  74188.141  65917.064      0.050
EXECUTE-STATE                     650000 101952.387  22885.820      0.035
IS_TABLE?                        1126542   7948.569   7948.569      0.007
UPDATE-CURRENT-STATE              187757  76887.673   2466.914      0.013
GO                                 10000 102423.722    471.335      0.047
WIGGLE                            462205    344.606    344.606      0.001
TRIGGER_RULES_OF_CURRENT_STATE    650000    212.845    212.845      0.000
HAS-FREE-CHIP-HERE?               215675    173.219    173.219      0.001
IS-EMPTY-HERE?                     59094    140.873    140.873      0.002
ACTION_OF_CURRENT_STATE           650000    122.532    122.532      0.000
GET_STATE                         187757    112.160    112.160      0.001
EXPIRED-AT                        187774     75.171     75.171      0.000
PICK-UP-CHIP                      156522     71.535     71.535      0.000
TIME-AFTER                         62584     66.069     66.069      0.001
SEARCH-FOR-CHIP                   215695    195.755     45.819      0.000
FIND-NEW-PILE                     144408    140.254     36.292      0.000
FIND-PLACE-TO-PUT-DOWN-CHIP        59100     77.270     26.534      0.000
PUT-DOWN-CHIP                      31273     25.883     25.883      0.001
GET-AWAY                           43002     60.121     20.149      0.000

Sorted by Inclusive Time
GO                                 10000 102423.722    471.335      0.047
EXECUTE-STATE                     650000 101952.387  22885.820      0.035
UPDATE-CURRENT-STATE              187757  76887.673   2466.914      0.013
COPIED_TABLE_OF                  1314299  74188.141  65917.064      0.050
IS_TABLE?                        1126542   7948.569   7948.569      0.007
WIGGLE                            462205    344.606    344.606      0.001
TRIGGER_RULES_OF_CURRENT_STATE    650000    212.845    212.845      0.000
SEARCH-FOR-CHIP                   215695    195.755     45.819      0.000
HAS-FREE-CHIP-HERE?               215675    173.219    173.219      0.001
IS-EMPTY-HERE?                     59094    140.873    140.873      0.002
FIND-NEW-PILE                     144408    140.254     36.292      0.000
ACTION_OF_CURRENT_STATE           650000    122.532    122.532      0.000
GET_STATE                         187757    112.160    112.160      0.001
FIND-PLACE-TO-PUT-DOWN-CHIP        59100     77.270     26.534      0.000
EXPIRED-AT                        187774     75.171     75.171      0.000
PICK-UP-CHIP                      156522     71.535     71.535      0.000
TIME-AFTER                         62584     66.069     66.069      0.001
GET-AWAY                           43002     60.121     20.149      0.000
PUT-DOWN-CHIP                      31273     25.883     25.883      0.001

Sorted by Number of Calls
COPIED_TABLE_OF                  1314299  74188.141  65917.064      0.050
IS_TABLE?                        1126542   7948.569   7948.569      0.007
EXECUTE-STATE                     650000 101952.387  22885.820      0.035
TRIGGER_RULES_OF_CURRENT_STATE    650000    212.845    212.845      0.000
ACTION_OF_CURRENT_STATE           650000    122.532    122.532      0.000
WIGGLE                            462205    344.606    344.606      0.001
SEARCH-FOR-CHIP                   215695    195.755     45.819      0.000
HAS-FREE-CHIP-HERE?               215675    173.219    173.219      0.001
EXPIRED-AT                        187774     75.171     75.171      0.000
UPDATE-CURRENT-STATE              187757  76887.673   2466.914      0.013
GET_STATE                         187757    112.160    112.160      0.001
PICK-UP-CHIP                      156522     71.535     71.535      0.000
FIND-NEW-PILE                     144408    140.254     36.292      0.000
TIME-AFTER                         62584     66.069     66.069      0.001
FIND-PLACE-TO-PUT-DOWN-CHIP        59100     77.270     26.534      0.000
IS-EMPTY-HERE?                     59094    140.873    140.873      0.002
GET-AWAY                           43002     60.121     20.149      0.000
PUT-DOWN-CHIP                      31273     25.883     25.883      0.001
GO                                 10000 102423.722    471.335      0.047
END PROFILING DUMP

---




observer> repeat 10000 [go] profiler:stop  print profiler:report
BEGIN PROFILING DUMP
Sorted by Exclusive Time
Name                               Calls Incl T(ms) Excl T(ms) Excl/calls
GO                                 10000   4861.131   4264.421      0.426
WIGGLE                           1637476    189.992    189.992      0.000
SEARCH-FOR-CHIP                   748167     85.719     85.719      0.000
FIND-NEW-PILE                     652411     75.100     75.100      0.000
PUT-DOWN-CHIP                     149679     40.143     40.143      0.000
GET-AWAY                           87219     25.284     25.284      0.000

Sorted by Inclusive Time
GO                                 10000   4861.131   4264.421      0.426
WIGGLE                           1637476    189.992    189.992      0.000
SEARCH-FOR-CHIP                   748167     85.719     85.719      0.000
FIND-NEW-PILE                     652411     75.100     75.100      0.000
PUT-DOWN-CHIP                     149679     40.143     40.143      0.000
GET-AWAY                           87219     25.284     25.284      0.000

Sorted by Number of Calls
WIGGLE                           1637476    189.992    189.992      0.000
SEARCH-FOR-CHIP                   748167     85.719     85.719      0.000
FIND-NEW-PILE                     652411     75.100     75.100      0.000
PUT-DOWN-CHIP                     149679     40.143     40.143      0.000
GET-AWAY                           87219     25.284     25.284      0.000
GO                                 10000   4861.131   4264.421      0.426
END PROFILING DUMP
