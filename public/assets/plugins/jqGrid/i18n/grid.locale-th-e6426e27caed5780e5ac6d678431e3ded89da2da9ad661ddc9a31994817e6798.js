!function(e){e.jgrid=e.jgrid||{},e.extend(e.jgrid,{defaults:{recordtext:"\u0e41\u0e2a\u0e14\u0e07 {0} - {1} \u0e08\u0e32\u0e01 {2}",emptyrecords:"\u0e44\u0e21\u0e48\u0e1e\u0e1a\u0e02\u0e49\u0e2d\u0e21\u0e39\u0e25",loadtext:"\u0e01\u0e33\u0e25\u0e31\u0e07\u0e23\u0e49\u0e2d\u0e07\u0e02\u0e2d\u0e02\u0e49\u0e2d\u0e21\u0e39\u0e25...",pgtext:"\u0e2b\u0e19\u0e49\u0e32 {0} \u0e08\u0e32\u0e01 {1}"},search:{caption:"\u0e01\u0e33\u0e25\u0e31\u0e07\u0e04\u0e49\u0e19\u0e2b\u0e32...",Find:"\u0e04\u0e49\u0e19\u0e2b\u0e32",Reset:"\u0e04\u0e37\u0e19\u0e04\u0e48\u0e32\u0e01\u0e25\u0e31\u0e1a",odata:[{oper:"eq",text:"\u0e40\u0e17\u0e48\u0e32\u0e01\u0e31\u0e1a"},{oper:"ne",text:"\u0e44\u0e21\u0e48\u0e40\u0e17\u0e48\u0e32\u0e01\u0e31\u0e1a"},{oper:"lt",text:"\u0e19\u0e49\u0e2d\u0e22\u0e01\u0e27\u0e48\u0e32"},{oper:"le",text:"\u0e44\u0e21\u0e48\u0e21\u0e32\u0e01\u0e01\u0e27\u0e48\u0e32"},{oper:"gt",text:"\u0e21\u0e32\u0e01\u0e01\u0e01\u0e27\u0e48\u0e32"},{oper:"ge",text:"\u0e44\u0e21\u0e48\u0e19\u0e49\u0e2d\u0e22\u0e01\u0e27\u0e48\u0e32"},{oper:"bw",text:"\u0e02\u0e36\u0e49\u0e19\u0e15\u0e49\u0e19\u0e14\u0e49\u0e27\u0e22"},{oper:"bn",text:"\u0e44\u0e21\u0e48\u0e02\u0e36\u0e49\u0e19\u0e15\u0e49\u0e19\u0e14\u0e49\u0e27\u0e22"},{oper:"in",text:"\u0e21\u0e35\u0e04\u0e33\u0e43\u0e14\u0e04\u0e33\u0e2b\u0e19\u0e36\u0e48\u0e07\u0e43\u0e19"},{oper:"ni",text:"\u0e44\u0e21\u0e48\u0e21\u0e35\u0e04\u0e33\u0e43\u0e14\u0e04\u0e33\u0e2b\u0e19\u0e36\u0e48\u0e07\u0e43\u0e19"},{oper:"ew",text:"\u0e25\u0e07\u0e17\u0e49\u0e32\u0e22\u0e14\u0e49\u0e27\u0e22"},{oper:"en",text:"\u0e44\u0e21\u0e48\u0e25\u0e07\u0e17\u0e49\u0e32\u0e22\u0e14\u0e49\u0e27\u0e22"},{oper:"cn",text:"\u0e21\u0e35\u0e04\u0e33\u0e27\u0e48\u0e32"},{oper:"nc",text:"\u0e44\u0e21\u0e48\u0e21\u0e35\u0e04\u0e33\u0e27\u0e48\u0e32"},{oper:"nu",text:"is null"},{oper:"nn",text:"is not null"}],groupOps:[{op:"\u0e41\u0e25\u0e30",text:"\u0e17\u0e31\u0e49\u0e07\u0e2b\u0e21\u0e14"},{op:"\u0e2b\u0e23\u0e37\u0e2d",text:"\u0e43\u0e14\u0e46"}],operandTitle:"Click to select search operation.",resetTitle:"Reset Search Value"},edit:{addCaption:"\u0e40\u0e1e\u0e34\u0e48\u0e21\u0e02\u0e49\u0e2d\u0e21\u0e39\u0e25",editCaption:"\u0e41\u0e01\u0e49\u0e44\u0e02\u0e02\u0e49\u0e2d\u0e21\u0e39\u0e25",bSubmit:"\u0e1a\u0e31\u0e19\u0e17\u0e36\u0e01",bCancel:"\u0e22\u0e01\u0e40\u0e25\u0e34\u0e01",bClose:"\u0e1b\u0e34\u0e14",saveData:"\u0e04\u0e38\u0e13\u0e15\u0e49\u0e2d\u0e07\u0e01\u0e32\u0e23\u0e1a\u0e31\u0e19\u0e17\u0e36\u0e01\u0e32\u0e23\u0e41\u0e01\u0e49\u0e44\u0e02 \u0e43\u0e0a\u0e48\u0e2b\u0e23\u0e37\u0e2d\u0e44\u0e21\u0e48?",bYes:"\u0e1a\u0e31\u0e19\u0e17\u0e36\u0e01",bNo:"\u0e25\u0e30\u0e17\u0e34\u0e49\u0e07\u0e01\u0e32\u0e23\u0e41\u0e01\u0e49\u0e44\u0e02",bExit:"\u0e22\u0e01\u0e40\u0e25\u0e34\u0e01",msg:{required:"\u0e02\u0e49\u0e2d\u0e21\u0e39\u0e25\u0e19\u0e35\u0e49\u0e08\u0e33\u0e40\u0e1b\u0e47\u0e19",number:"\u0e01\u0e23\u0e38\u0e13\u0e32\u0e01\u0e23\u0e2d\u0e01\u0e2b\u0e21\u0e32\u0e22\u0e40\u0e25\u0e02\u0e43\u0e2b\u0e49\u0e16\u0e39\u0e01\u0e15\u0e49\u0e2d\u0e07",minValue:"\u0e04\u0e48\u0e32\u0e02\u0e2d\u0e07\u0e02\u0e49\u0e2d\u0e21\u0e39\u0e25\u0e19\u0e35\u0e49\u0e15\u0e49\u0e2d\u0e07\u0e44\u0e21\u0e48\u0e19\u0e49\u0e2d\u0e22\u0e01\u0e27\u0e48\u0e32",maxValue:"\u0e04\u0e48\u0e32\u0e02\u0e2d\u0e07\u0e02\u0e49\u0e2d\u0e21\u0e39\u0e25\u0e19\u0e35\u0e49\u0e15\u0e49\u0e2d\u0e07\u0e44\u0e21\u0e48\u0e21\u0e32\u0e01\u0e01\u0e27\u0e48\u0e32",email:"\u0e2d\u0e35\u0e40\u0e21\u0e25\u0e25\u0e4c\u0e19\u0e35\u0e49\u0e44\u0e21\u0e48\u0e16\u0e39\u0e01\u0e15\u0e49\u0e2d\u0e07",integer:"\u0e01\u0e23\u0e38\u0e13\u0e32\u0e01\u0e23\u0e2d\u0e01\u0e40\u0e1b\u0e47\u0e19\u0e08\u0e33\u0e19\u0e27\u0e19\u0e40\u0e15\u0e47\u0e21",date:"\u0e01\u0e23\u0e38\u0e13\u0e32\u0e01\u0e23\u0e2d\u0e01\u0e27\u0e31\u0e19\u0e17\u0e35\u0e48\u0e43\u0e2b\u0e49\u0e16\u0e39\u0e01\u0e15\u0e49\u0e2d\u0e07",url:"URL \u0e44\u0e21\u0e48\u0e16\u0e39\u0e01\u0e15\u0e49\u0e2d\u0e07 URL \u0e08\u0e33\u0e40\u0e1b\u0e47\u0e19\u0e15\u0e49\u0e2d\u0e07\u0e02\u0e36\u0e49\u0e19\u0e15\u0e49\u0e19\u0e14\u0e49\u0e27\u0e22 'http://' \u0e2b\u0e23\u0e37\u0e2d 'https://'",nodefined:"\u0e44\u0e21\u0e48\u0e44\u0e14\u0e49\u0e16\u0e39\u0e01\u0e01\u0e33\u0e2b\u0e19\u0e14\u0e04\u0e48\u0e32!",novalue:"\u0e15\u0e49\u0e2d\u0e07\u0e01\u0e32\u0e23\u0e01\u0e32\u0e23\u0e04\u0e37\u0e19\u0e04\u0e48\u0e32!",customarray:"\u0e1f\u0e31\u0e07\u0e01\u0e4c\u0e0a\u0e31\u0e19\u0e17\u0e35\u0e48\u0e2a\u0e23\u0e49\u0e32\u0e07\u0e02\u0e36\u0e49\u0e19\u0e15\u0e49\u0e2d\u0e07\u0e2a\u0e48\u0e07\u0e04\u0e48\u0e32\u0e01\u0e25\u0e31\u0e1a\u0e40\u0e1b\u0e47\u0e19\u0e41\u0e1a\u0e1a\u0e41\u0e2d\u0e40\u0e23\u0e22\u0e4c",customfcheck:"\u0e23\u0e30\u0e1a\u0e1a\u0e15\u0e49\u0e2d\u0e07\u0e01\u0e32\u0e23\u0e1f\u0e31\u0e07\u0e01\u0e4c\u0e0a\u0e31\u0e19\u0e17\u0e35\u0e48\u0e2a\u0e23\u0e49\u0e32\u0e07\u0e02\u0e36\u0e49\u0e19\u0e2a\u0e33\u0e2b\u0e23\u0e31\u0e1a\u0e01\u0e32\u0e23\u0e15\u0e23\u0e27\u0e08\u0e2a\u0e2d\u0e1a!"}},view:{caption:"\u0e40\u0e23\u0e35\u0e22\u0e01\u0e14\u0e39\u0e02\u0e49\u0e2d\u0e21\u0e39\u0e25",bClose:"\u0e1b\u0e34\u0e14"},del:{caption:"\u0e25\u0e1a\u0e02\u0e49\u0e2d\u0e21\u0e39\u0e25",msg:"\u0e04\u0e38\u0e13\u0e15\u0e49\u0e2d\u0e07\u0e01\u0e32\u0e23\u0e25\u0e1a\u0e02\u0e49\u0e2d\u0e21\u0e39\u0e25\u0e17\u0e35\u0e48\u0e16\u0e39\u0e01\u0e40\u0e25\u0e37\u0e2d\u0e01 \u0e43\u0e0a\u0e48\u0e2b\u0e23\u0e37\u0e2d\u0e44\u0e21\u0e48?",bSubmit:"\u0e15\u0e49\u0e2d\u0e07\u0e01\u0e32\u0e23\u0e25\u0e1a",bCancel:"\u0e22\u0e01\u0e40\u0e25\u0e34\u0e01"},nav:{edittext:"",edittitle:"\u0e41\u0e01\u0e49\u0e44\u0e02\u0e02\u0e49\u0e2d\u0e21\u0e39\u0e25",addtext:"",addtitle:"\u0e40\u0e1e\u0e34\u0e48\u0e21\u0e02\u0e49\u0e2d\u0e21\u0e39\u0e25",deltext:"",deltitle:"\u0e25\u0e1a\u0e02\u0e49\u0e2d\u0e21\u0e39\u0e25",searchtext:"",searchtitle:"\u0e04\u0e49\u0e19\u0e2b\u0e32\u0e02\u0e49\u0e2d\u0e21\u0e39\u0e25",refreshtext:"",refreshtitle:"\u0e23\u0e35\u0e40\u0e1f\u0e23\u0e0a",alertcap:"\u0e04\u0e33\u0e40\u0e15\u0e37\u0e2d\u0e19",alerttext:"\u0e01\u0e23\u0e38\u0e13\u0e32\u0e40\u0e25\u0e37\u0e2d\u0e01\u0e02\u0e49\u0e2d\u0e21\u0e39\u0e25",viewtext:"",viewtitle:"\u0e14\u0e39\u0e23\u0e32\u0e22\u0e25\u0e30\u0e40\u0e2d\u0e35\u0e22\u0e14\u0e02\u0e49\u0e2d\u0e21\u0e39\u0e25"},col:{caption:"\u0e01\u0e23\u0e38\u0e13\u0e32\u0e40\u0e25\u0e37\u0e2d\u0e01\u0e04\u0e2d\u0e25\u0e31\u0e21\u0e19\u0e4c",bSubmit:"\u0e15\u0e01\u0e25\u0e07",bCancel:"\u0e22\u0e01\u0e40\u0e25\u0e34\u0e01"},errors:{errcap:"\u0e40\u0e01\u0e34\u0e14\u0e04\u0e27\u0e32\u0e21\u0e1c\u0e34\u0e14\u0e1e\u0e25\u0e32\u0e14",nourl:"\u0e44\u0e21\u0e48\u0e44\u0e14\u0e49\u0e01\u0e33\u0e2b\u0e19\u0e14 URL",norecords:"\u0e44\u0e21\u0e48\u0e21\u0e35\u0e02\u0e49\u0e2d\u0e21\u0e39\u0e25\u0e43\u0e2b\u0e49\u0e14\u0e33\u0e40\u0e19\u0e34\u0e19\u0e01\u0e32\u0e23",model:"\u0e08\u0e33\u0e19\u0e27\u0e19\u0e04\u0e2d\u0e25\u0e31\u0e21\u0e19\u0e4c\u0e44\u0e21\u0e48\u0e40\u0e17\u0e48\u0e32\u0e01\u0e31\u0e1a\u0e08\u0e33\u0e19\u0e27\u0e19\u0e04\u0e2d\u0e25\u0e31\u0e21\u0e19\u0e4c\u0e42\u0e21\u0e40\u0e14\u0e25!"},formatter:{integer:{thousandsSeparator:" ",defaultValue:"0"},number:{decimalSeparator:".",thousandsSeparator:" ",decimalPlaces:2,defaultValue:"0.00"},currency:{decimalSeparator:".",thousandsSeparator:" ",decimalPlaces:2,prefix:"",suffix:"",defaultValue:"0.00"},date:{dayNames:["\u0e2d\u0e32","\u0e08","\u0e2d","\u0e1e","\u0e1e\u0e24","\u0e28","\u0e2a","\u0e2d\u0e32\u0e17\u0e34\u0e15\u0e22\u0e4c","\u0e08\u0e31\u0e19\u0e17\u0e23\u0e4c","\u0e2d\u0e31\u0e07\u0e04\u0e32\u0e23","\u0e1e\u0e38\u0e18","\u0e1e\u0e24\u0e2b\u0e31\u0e2a\u0e1a\u0e14\u0e35","\u0e28\u0e39\u0e01\u0e23\u0e4c","\u0e40\u0e2a\u0e32\u0e23\u0e4c"],monthNames:["\u0e21.\u0e04.","\u0e01.\u0e1e.","\u0e21\u0e35.\u0e04.","\u0e40\u0e21.\u0e22.","\u0e1e.\u0e04.","\u0e21\u0e34.\u0e22.","\u0e01.\u0e04.","\u0e2a.\u0e04.","\u0e01.\u0e22.","\u0e15.\u0e04.","\u0e1e.\u0e22.","\u0e18.\u0e04.","\u0e21\u0e01\u0e23\u0e32\u0e04\u0e21","\u0e01\u0e38\u0e21\u0e20\u0e32\u0e1e\u0e31\u0e19\u0e18\u0e4c","\u0e21\u0e35\u0e19\u0e32\u0e04\u0e21","\u0e40\u0e21\u0e29\u0e32\u0e22\u0e19","\u0e1e\u0e24\u0e29\u0e20\u0e32\u0e04\u0e21","\u0e21\u0e34\u0e16\u0e38\u0e19\u0e32\u0e22\u0e19","\u0e01\u0e23\u0e01\u0e0f\u0e32\u0e04\u0e21","\u0e2a\u0e34\u0e07\u0e2b\u0e32\u0e04\u0e21","\u0e01\u0e31\u0e19\u0e22\u0e32\u0e22\u0e19","\u0e15\u0e38\u0e25\u0e32\u0e04\u0e21","\u0e1e\u0e24\u0e28\u0e08\u0e34\u0e01\u0e32\u0e22\u0e19","\u0e18\u0e31\u0e19\u0e27\u0e32\u0e04\u0e21"],AmPm:["am","pm","AM","PM"],S:function(e){return""},srcformat:"Y-m-d",newformat:"d/m/Y",parseRe:/[#%\\\/:_;.,\t\s-]/,masks:{ISO8601Long:"Y-m-d H:i:s",ISO8601Short:"Y-m-d",ShortDate:"n/j/Y",LongDate:"l, F d, Y",FullDateTime:"l, F d, Y g:i:s A",MonthDay:"F d",ShortTime:"g:i A",LongTime:"g:i:s A",SortableDateTime:"Y-m-d\\TH:i:s",UniversalSortableDateTime:"Y-m-d H:i:sO",YearMonth:"F, Y"},reformatAfterEdit:!1},baseLinkUrl:"",showAction:"",target:"",checkbox:{disabled:!0},idName:"id"}})}(jQuery);