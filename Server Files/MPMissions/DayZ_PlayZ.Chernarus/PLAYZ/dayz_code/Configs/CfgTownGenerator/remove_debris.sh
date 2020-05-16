

sed 's/^[^//]*"Rubbish[0-9]"/\/\/&/' -i PLAYZ_CfgTownGeneratorDefault.hpp
sed -r 's/^[^//]*"[a-zA-Z0-9]+Wreck"/\/\/&/' -i PLAYZ_CfgTownGeneratorDefault.hpp
sed 's/^[^//]*"Land_Misc_Rubble_EP1"/\/\/&/' -i PLAYZ_CfgTownGeneratorDefault.hpp
sed 's/^[^//]*"Fort_Barricade"/\/\/&/' -i PLAYZ_CfgTownGeneratorDefault.hpp
sed 's/^[^//]*"Land_Misc_Garb_Heap_EP1"/\/\/&/' -i PLAYZ_CfgTownGeneratorDefault.hpp
sed 's/^[^//]*"RoadBarrier_long"/\/\/&/' -i PLAYZ_CfgTownGeneratorDefault.hpp
sed 's/^[^//]*"Land_CncBlock_Stripes"/\/\/&/' -i PLAYZ_CfgTownGeneratorDefault.hpp
sed 's/^[^//]*"Land_CncBlock_D"/\/\/&/' -i PLAYZ_CfgTownGeneratorDefault.hpp

