!function(e){e.jgrid=e.jgrid||{},e.extend(e.jgrid,{defaults:{recordtext:"{0}-{1} listeleniyor. Toplam:{2}",emptyrecords:"Kay\u0131t bulunamad\u0131",loadtext:"Y\xfckleniyor...",pgtext:"{0}/{1}. Sayfa"},search:{caption:"Arama...",Find:"Bul",Reset:"Temizle",odata:[{oper:"eq",text:"e\u015fit"},{oper:"ne",text:"e\u015fit de\u011fil"},{oper:"lt",text:"daha az"},{oper:"le",text:"daha az veya e\u015fit"},{oper:"gt",text:"daha fazla"},{oper:"ge",text:"daha fazla veya e\u015fit"},{oper:"bw",text:"ile ba\u015flayan"},{oper:"bn",text:"ile ba\u015flamayan"},{oper:"in",text:"i\xe7inde"},{oper:"ni",text:"i\xe7inde de\u011fil"},{oper:"ew",text:"ile biten"},{oper:"en",text:"ile bitmeyen"},{oper:"cn",text:"i\xe7eren"},{oper:"nc",text:"i\xe7ermeyen"},{oper:"nu",text:"is null"},{oper:"nn",text:"is not null"}],groupOps:[{op:"VE",text:"t\xfcm"},{op:"VEYA",text:"herhangi"}],operandTitle:"Click to select search operation.",resetTitle:"Reset Search Value"},edit:{addCaption:"Kay\u0131t Ekle",editCaption:"Kay\u0131t D\xfczenle",bSubmit:"G\xf6nder",bCancel:"\u0130ptal",bClose:"Kapat",saveData:"Veriler de\u011fi\u015fti! Kay\u0131t edilsin mi?",bYes:"Evet",bNo:"Hay\u0131t",bExit:"\u0130ptal",msg:{required:"Alan gerekli",number:"L\xfctfen bir numara giriniz",minValue:"girilen de\u011fer daha b\xfcy\xfck ya da buna e\u015fit olmal\u0131d\u0131r",maxValue:"girilen de\u011fer daha k\xfc\xe7\xfck ya da buna e\u015fit olmal\u0131d\u0131r",email:"ge\xe7erli bir e-posta adresi de\u011fildir",integer:"L\xfctfen bir tamsay\u0131 giriniz",url:"Ge\xe7erli bir URL de\u011fil. ('http://' or 'https://') \xf6n eki gerekli.",nodefined:" is not defined!",novalue:" return value is required!",customarray:"Custom function should return array!",customfcheck:"Custom function should be present in case of custom checking!"}},view:{caption:"Kay\u0131t G\xf6r\xfcnt\xfcle",bClose:"Kapat"},del:{caption:"Sil",msg:"Se\xe7ilen kay\u0131tlar silinsin mi?",bSubmit:"Sil",bCancel:"\u0130ptal"},nav:{edittext:" ",edittitle:"Se\xe7ili sat\u0131r\u0131 d\xfczenle",addtext:" ",addtitle:"Yeni sat\u0131r ekle",deltext:" ",deltitle:"Se\xe7ili sat\u0131r\u0131 sil",searchtext:" ",searchtitle:"Kay\u0131tlar\u0131 bul",refreshtext:"",refreshtitle:"Tabloyu yenile",alertcap:"Uyar\u0131",alerttext:"L\xfctfen bir sat\u0131r se\xe7iniz",viewtext:"",viewtitle:"Se\xe7ilen sat\u0131r\u0131 g\xf6r\xfcnt\xfcle"},col:{caption:"S\xfctunlar\u0131 g\xf6ster/gizle",bSubmit:"G\xf6nder",bCancel:"\u0130ptal"},errors:{errcap:"Hata",nourl:"Bir url yap\u0131land\u0131r\u0131lmam\u0131\u015f",norecords:"\u0130\u015flem yap\u0131lacak bir kay\u0131t yok",model:"colNames uzunlu\u011fu <> colModel!"},formatter:{integer:{thousandsSeparator:" ",defaultValue:"0"},number:{decimalSeparator:".",thousandsSeparator:" ",decimalPlaces:2,defaultValue:"0.00"},currency:{decimalSeparator:".",thousandsSeparator:" ",decimalPlaces:2,prefix:"",suffix:"",defaultValue:"0.00"},date:{dayNames:["Paz","Pts","Sal","\xc7ar","Per","Cum","Cts","Pazar","Pazartesi","Sal\u0131","\xc7ar\u015famba","Per\u015fembe","Cuma","Cumartesi"],monthNames:["Oca","\u015eub","Mar","Nis","May","Haz","Tem","A\u011fu","Eyl","Eki","Kas","Ara","Ocak","\u015eubat","Mart","Nisan","May\u0131s","Haziran","Temmuz","A\u011fustos","Eyl\xfcl","Ekim","Kas\u0131m","Aral\u0131k"],AmPm:["am","pm","AM","PM"],S:function(e){return 11>e||e>13?["st","nd","rd","th"][Math.min((e-1)%10,3)]:"th"},srcformat:"Y-m-d",newformat:"d/m/Y",parseRe:/[#%\\\/:_;.,\t\s-]/,masks:{ISO8601Long:"Y-m-d H:i:s",ISO8601Short:"Y-m-d",ShortDate:"n/j/Y",LongDate:"l, F d, Y",FullDateTime:"l, F d, Y g:i:s A",MonthDay:"F d",ShortTime:"g:i A",LongTime:"g:i:s A",SortableDateTime:"Y-m-d\\TH:i:s",UniversalSortableDateTime:"Y-m-d H:i:sO",YearMonth:"F, Y"},reformatAfterEdit:!1},baseLinkUrl:"",showAction:"",target:"",checkbox:{disabled:!0},idName:"id"}})}(jQuery);