!function(e){e.jgrid=e.jgrid||{},e.extend(e.jgrid,{defaults:{recordtext:"Per\u017ei\u016brima {0} - {1} i\u0161 {2}",emptyrecords:"\u012era\u0161\u0173 n\u0117ra",loadtext:"Kraunama...",pgtext:"Puslapis {0} i\u0161 {1}"},search:{caption:"Paie\u0161ka...",Find:"Ie\u0161koti",Reset:"Atstatyti",odata:[{oper:"eq",text:"lygu"},{oper:"ne",text:"nelygu"},{oper:"lt",text:"ma\u017eiau"},{oper:"le",text:"ma\u017eiau arba lygu"},{oper:"gt",text:"daugiau"},{oper:"ge",text:"daugiau arba lygu"},{oper:"bw",text:"prasideda"},{oper:"bn",text:"neprasideda"},{oper:"in",text:"reik\u0161m\u0117 yra"},{oper:"ni",text:"reik\u0161m\u0117s n\u0117ra"},{oper:"ew",text:"baigiasi"},{oper:"en",text:"nesibaigia"},{oper:"cn",text:"yra sudarytas"},{oper:"nc",text:"n\u0117ra sudarytas"},{oper:"nu",text:"is null"},{oper:"nn",text:"is not null"}],groupOps:[{op:"AND",text:"visi"},{op:"OR",text:"bet kuris"}],operandTitle:"Click to select search operation.",resetTitle:"Reset Search Value"},edit:{addCaption:"Sukurti \u012fra\u0161\u0105",editCaption:"Redaguoti \u012fra\u0161\u0105",bSubmit:"I\u0161saugoti",bCancel:"At\u0161aukti",bClose:"U\u017edaryti",saveData:"Duomenys buvo pakeisti! I\u0161saugoti pakeitimus?",bYes:"Taip",bNo:"Ne",bExit:"At\u0161aukti",msg:{required:"Privalomas laukas",number:"\u012eveskite tinkam\u0105 numer\u012f",minValue:"reik\u0161m\u0117 turi b\u016bti didesn\u0117 arba lygi ",maxValue:"reik\u0161m\u0117 turi b\u016bti ma\u017eesn\u0117 arba lygi",email:"neteisingas el. pa\u0161to adresas",integer:"\u012eveskite teising\u0105 sveik\u0105j\u012f skai\u010di\u0173",date:"\u012eveskite teising\u0105 dat\u0105",url:"blogas adresas. Nepamir\u0161kite prid\u0117ti ('http://' arba 'https://')",nodefined:" n\u0117ra apibr\u0117\u017eta!",novalue:" turi b\u016bti gra\u017einama kokia nors reik\u0161m\u0117!",customarray:"Custom f-ja turi gr\u0105\u017einti masyv\u0105!",customfcheck:"Custom f-ja t\u016br\u0117t\u0173 b\u016bti sukurta, prie\u0161 bandant j\u0105 naudoti!"}},view:{caption:"Per\u017ei\u016br\u0117ti \u012fra\u0161us",bClose:"U\u017edaryti"},del:{caption:"I\u0161trinti",msg:"I\u0161trinti pa\u017eym\u0117tus \u012fra\u0161us(-\u0105)?",bSubmit:"I\u0161trinti",bCancel:"At\u0161aukti"},nav:{edittext:"",edittitle:"Redaguoti pa\u017eym\u0117t\u0105 eilut\u0119",addtext:"",addtitle:"Prid\u0117ti nauj\u0105 eilut\u0119",deltext:"",deltitle:"I\u0161trinti pa\u017eym\u0117t\u0105 eilut\u0119",searchtext:"",searchtitle:"Rasti \u012fra\u0161us",refreshtext:"",refreshtitle:"Perkrauti lentel\u0119",alertcap:"\u012esp\u0117jimas",alerttext:"Pasirinkite eilut\u0119",viewtext:"",viewtitle:"Per\u017ei\u016br\u0117ti pasirinkt\u0105 eilut\u0119"},col:{caption:"Pasirinkti stulpelius",bSubmit:"Gerai",bCancel:"At\u0161aukti"},errors:{errcap:"Klaida",nourl:"Url reik\u0161m\u0117 turi b\u016bti perduota",norecords:"N\u0117ra \u012fra\u0161\u0173, kuriuos b\u016bt\u0173 galima apdoroti",model:"colNames skai\u010dius <> colModel skai\u010diui!"},formatter:{integer:{thousandsSeparator:"",defaultValue:"0"},number:{decimalSeparator:",",thousandsSeparator:"",decimalPlaces:2,defaultValue:"0.00"},currency:{decimalSeparator:",",thousandsSeparator:"",decimalPlaces:2,prefix:"",suffix:"",defaultValue:"0.00"},date:{dayNames:["Sek","Pir","Ant","Tre","Ket","Pen","\u0160e\u0161","Sekmadienis","Pirmadienis","Antradienis","Tre\u010diadienis","Ketvirtadienis","Penktadienis","\u0160e\u0161tadienis"],monthNames:["Sau","Vas","Kov","Bal","Geg","Bir","Lie","Rugj","Rugs","Spa","Lap","Gru","Sausis","Vasaris","Kovas","Balandis","Gegu\u017e\u0117","Bir\u017eelis","Liepa","Rugpj\u016btis","Rugs\u0117jis","Spalis","Lapkritis","Gruodis"],AmPm:["am","pm","AM","PM"],S:function(e){return 11>e||e>13?["st","nd","rd","th"][Math.min((e-1)%10,3)]:"th"},srcformat:"Y-m-d",newformat:"d/m/Y",parseRe:/[#%\\\/:_;.,\t\s-]/,masks:{ISO8601Long:"Y-m-d H:i:s",ISO8601Short:"Y-m-d",ShortDate:"n/j/Y",LongDate:"l, F d, Y",FullDateTime:"l, F d, Y g:i:s A",MonthDay:"F d",ShortTime:"g:i A",LongTime:"g:i:s A",SortableDateTime:"Y-m-d\\TH:i:s",UniversalSortableDateTime:"Y-m-d H:i:sO",YearMonth:"F, Y"},reformatAfterEdit:!1},baseLinkUrl:"",showAction:"",target:"",checkbox:{disabled:!0},idName:"id"}})}(jQuery);