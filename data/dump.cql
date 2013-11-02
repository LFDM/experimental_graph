begin
create (_1:`Person` {`abbr`:"Caes.", `name`:"Gaius Iulius Caesar"})
create (_2:`Person` {`name`:"Orgetorix"})
create (_3:`Work` {`abbr`:"Gall.", `name`:"De bello Gallico"})
create (_4:`Work` {`abbr`:"civ.", `name`:"De bello civile"})
create (_5:`Lemma` {`name`:"Gaius"})
create (_6:`Lemma` {`name`:"Caesar"})
create (_7:`Lemma` {`name`:"Iulius"})
create (_8 {`index`:1, `type`:"book"})
create (_9 {`index`:2, `type`:"book"})
create (_10 {`index`:3, `type`:"book"})
create (_11 {`index`:4, `type`:"book"})
create (_12 {`index`:5, `type`:"book"})
create (_13 {`index`:6, `type`:"book"})
create (_14 {`index`:7, `type`:"book"})
create (_15 {`index`:8, `type`:"book"})
create (_16 {`index`:1, `type`:"book"})
create (_17 {`index`:2, `type`:"book"})
create (_18 {`index`:3, `type`:"book"})
create (_19 {`index`:1, `type`:"chapter"})
create (_20 {`index`:2, `type`:"chapter"})
create (_21 {`index`:3, `type`:"chapter"})
create (_22 {`index`:4, `type`:"chapter"})
create (_23 {`index`:5, `type`:"chapter"})
create (_24 {`index`:6, `type`:"chapter"})
create (_25 {`index`:7, `type`:"chapter"})
create (_26 {`index`:8, `type`:"chapter"})
create (_27 {`index`:9, `type`:"chapter"})
create (_28 {`index`:10, `type`:"chapter"})
create (_29 {`index`:11, `type`:"chapter"})
create (_30 {`index`:12, `type`:"chapter"})
create (_31 {`index`:13, `type`:"chapter"})
create (_32 {`index`:14, `type`:"chapter"})
create (_33 {`index`:15, `type`:"chapter"})
create (_34 {`index`:16, `type`:"chapter"})
create (_35 {`index`:17, `type`:"chapter"})
create (_36 {`index`:18, `type`:"chapter"})
create (_37 {`index`:19, `type`:"chapter"})
create (_38 {`index`:20, `type`:"chapter"})
create (_39 {`index`:21, `type`:"chapter"})
create (_40 {`index`:22, `type`:"chapter"})
create (_41 {`index`:23, `type`:"chapter"})
create (_42 {`index`:24, `type`:"chapter"})
create (_43 {`index`:25, `type`:"chapter"})
create (_44 {`index`:26, `type`:"chapter"})
create (_45 {`index`:27, `type`:"chapter"})
create (_46 {`index`:28, `type`:"chapter"})
create (_47 {`index`:29, `type`:"chapter"})
create (_48 {`index`:30, `type`:"chapter"})
create (_49 {`index`:31, `type`:"chapter"})
create (_50 {`index`:32, `type`:"chapter"})
create (_51 {`index`:33, `type`:"chapter"})
create (_52 {`index`:34, `type`:"chapter"})
create (_53 {`index`:35, `type`:"chapter"})
create (_54 {`index`:36, `type`:"chapter"})
create (_55 {`index`:37, `type`:"chapter"})
create (_56 {`index`:38, `type`:"chapter"})
create (_57 {`index`:39, `type`:"chapter"})
create (_58 {`index`:40, `type`:"chapter"})
create (_59 {`index`:41, `type`:"chapter"})
create (_60 {`index`:42, `type`:"chapter"})
create (_61 {`index`:43, `type`:"chapter"})
create (_62 {`index`:44, `type`:"chapter"})
create (_63 {`index`:45, `type`:"chapter"})
create (_64 {`index`:46, `type`:"chapter"})
create (_65 {`index`:47, `type`:"chapter"})
create (_66 {`index`:48, `type`:"chapter"})
create (_67 {`index`:49, `type`:"chapter"})
create (_68 {`index`:50, `type`:"chapter"})
create (_69 {`index`:51, `type`:"chapter"})
create (_70 {`index`:52, `type`:"chapter"})
create (_71 {`index`:53, `type`:"chapter"})
create (_72 {`index`:54, `type`:"chapter"})
create (_73:`Sentence` {`index`:1, `text`:"Apud Helvetios longe nobilissimus fuit et ditissimus Orgetorix."})
create (_74:`Sentence` {`index`:2, `text`:"Is M. Messala M. Pisone consulibus regni cupiditate inductus coniurationem nobilitatis fecit."})
create (_75:`Ethnos` {`name`:"Helvetii"})
create (_76:`Lemma` {`name`:"apud"})
create (_77:`Lemma` {`name`:"longus"})
create (_79:`Lemma` {`name`:"et"})
create (_80:`Lemma` {`name`:"dis"})
create (_81:`Lemma` {`name`:"is"})
create (_82:`Lemma`)
create (_83:`Lemma` {`name`:"Orgetorix"})
create (_84 {`a`:"b"})
create (_104:`Form` {`string`:"Orgetorix"})
create (_105:`Form` {`string`:"Orgetorigis"})
create (_106:`Form` {`string`:"Orgetorigi"})
create (_107:`Form` {`string`:"Orgetorigem"})
create (_108:`Form` {`string`:"Orgetorix"})
create (_109:`Form` {`string`:"Orgetorige"})
create (_118:`Token` {`index`:1, `string`:"Apud"})
create (_119:`Token` {`index`:2, `string`:"Helvetios"})
create (_120:`Token` {`index`:3, `string`:"longe"})
create (_121:`Token` {`index`:4, `string`:"nobilissimus"})
create (_122:`Token` {`index`:5, `string`:"fuit"})
create (_123:`Token` {`index`:6, `string`:"et"})
create (_124:`Token` {`index`:7, `string`:"ditissimus"})
create (_125:`Token` {`index`:8, `string`:"Orgetorix"})
create _1-[:`author_of`]->_3
create _1-[:`author_of`]->_4
create _1-[:`praenomen`]->_5
create _1-[:`cognomen`]->_6
create _1-[:`nomen_gentile`]->_7
create _3-[:`contains`]->_15
create _3-[:`contains`]->_14
create _3-[:`contains`]->_13
create _3-[:`contains`]->_12
create _3-[:`contains`]->_11
create _3-[:`contains`]->_10
create _3-[:`contains`]->_9
create _3-[:`contains`]->_8
create _4-[:`contains`]->_16
create _4-[:`contains`]->_17
create _4-[:`contains`]->_18
create _8-[:`contains`]->_72
create _8-[:`contains`]->_71
create _8-[:`contains`]->_70
create _8-[:`contains`]->_69
create _8-[:`contains`]->_68
create _8-[:`contains`]->_67
create _8-[:`contains`]->_66
create _8-[:`contains`]->_65
create _8-[:`contains`]->_64
create _8-[:`contains`]->_63
create _8-[:`contains`]->_62
create _8-[:`contains`]->_61
create _8-[:`contains`]->_60
create _8-[:`contains`]->_59
create _8-[:`contains`]->_58
create _8-[:`contains`]->_57
create _8-[:`contains`]->_56
create _8-[:`contains`]->_55
create _8-[:`contains`]->_54
create _8-[:`contains`]->_53
create _8-[:`contains`]->_52
create _8-[:`contains`]->_51
create _8-[:`contains`]->_50
create _8-[:`contains`]->_49
create _8-[:`contains`]->_48
create _8-[:`contains`]->_47
create _8-[:`contains`]->_46
create _8-[:`contains`]->_45
create _8-[:`contains`]->_44
create _8-[:`contains`]->_43
create _8-[:`contains`]->_42
create _8-[:`contains`]->_41
create _8-[:`contains`]->_40
create _8-[:`contains`]->_39
create _8-[:`contains`]->_38
create _8-[:`contains`]->_37
create _8-[:`contains`]->_36
create _8-[:`contains`]->_35
create _8-[:`contains`]->_34
create _8-[:`contains`]->_33
create _8-[:`contains`]->_32
create _8-[:`contains`]->_31
create _8-[:`contains`]->_30
create _8-[:`contains`]->_29
create _8-[:`contains`]->_28
create _8-[:`contains`]->_27
create _8-[:`contains`]->_26
create _8-[:`contains`]->_25
create _8-[:`contains`]->_24
create _8-[:`contains`]->_23
create _8-[:`contains`]->_22
create _8-[:`contains`]->_21
create _8-[:`contains`]->_20
create _8-[:`contains`]->_19
create _20-[:`contains`]->_74
create _20-[:`contains`]->_73
create _73-[:`PRED`]->_122
create _83-[:`form`]->_109
create _83-[:`form`]->_108
create _83-[:`form`]->_107
create _83-[:`form`]->_106
create _83-[:`form`]->_105
create _83-[:`form`]->_104
create _83-[:`nom`]->_104
create _83-[:`sg`]->_109
create _83-[:`sg`]->_108
create _83-[:`sg`]->_107
create _83-[:`sg`]->_106
create _83-[:`sg`]->_105
create _83-[:`sg`]->_104
create _83-[:`m`]->_109
create _83-[:`m`]->_108
create _83-[:`m`]->_107
create _83-[:`m`]->_106
create _83-[:`m`]->_105
create _83-[:`m`]->_104
create _83-[:`gen`]->_105
create _83-[:`dat`]->_106
create _83-[:`acc`]->_107
create _83-[:`voc`]->_108
create _83-[:`abl`]->_109
create _104-[:`occurs_as`]->_125
create _118-[:`ADV`]->_119
create _122-[:`AuxP`]->_118
create _122-[:`SBJ`]->_125
create _123-[:`ADV`]->_120
create _123-[:`ATR_CO`]->_121
create _123-[:`ATR_CO`]->_124
create _125-[:`COORD`]->_123
;
commit
