<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/tui-grid/tui-grid.css"
	type="text/css">
<link rel="stylesheet"
	href="https://uicdn.toast.com/select-box/latest/toastui-select-box.css" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<link href="resources/tui-grid/tui-grid.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
<link rel="stylesheet" href="resources/css/pgMg.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript"
	src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>
<script
	src="https://uicdn.toast.com/select-box/latest/toastui-select-box.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.1/xlsx.full.min.js"></script>
<script src="resources/tui-grid/tui-grid.js"></script>
<title>Program Management</title>
</head>
<body>

	<h2>프로그램 관리</h2>

	<!-- 셀렉트 박스  -->
	<div>
		<div>
			<button class="btn" id="save" type="button">
				<i class="fa fa-floppy-o" aria-hidden="true"></i> 저장
			</button>
			<button class="btn" id="search" type='button'>
				<i class="fa fa-search" aria-hidden="true"></i> 조회
			</button>
			<button class="btn" id="reset" type='button'>
				<i class="fa fa-repeat" aria-hidden="true"></i> 초기화
			</button>
		</div>
		<div id="selectBox"></div>
	</div>

	<!-- 프로그램 목록 -->
	<div>
		<div class="list-top">
			<div>
				<h3>프로그램목록</h3>
				<div>
					<span id="listCount"></span>건
				</div>
			</div>
			<div>
				<button class="btn" id="insert" type="button">
					<i class="fa fa-plus" aria-hidden="true"></i> 행추가
				</button>
				<button class="btn" id="delete" type='button'>
					<i class="fa fa-minus" aria-hidden="true"></i> 행삭제
				</button>
				<button class="btn" id="excel" type='button'>
					<i class="fa fa-file-excel-o" aria-hidden="true"></i> 엑셀
				</button>
			</div>
		</div>
		<div id="list"></div>
	</div>
	<script>

//element

//select
const selectBox = document.getElementById('selectBox');

//list
const listCount = document.getElementById('listCount');
const list = document.getElementById('list');

// 그리드 세팅
const Grid = tui.Grid;

//grid ThemeSetting
Grid.applyTheme('default',{
	grid:{
		border:"#eee",
	},
	area:{
		body:{
			background:"white",
		}
	},
	cell:{
		normal:{
			background:"white",
			border:"#eee",
			showVerticalBorder:true,
			showHorizontalBorder:true,
		},
		header:{
			background:"#EBF3FE",
			border:"#A1A1A1",
			text:"black"
		},
		rowHeader: {
		      border: "#eee",
		      showVerticalBorder: true
		    },
	}
});

//selectBox Grid
const selectBoxGrid = new Grid({
	el:selectBox,
    bodyHeight: 40,
    minBodyHeight: 40,
    focus:false,
    scrollX: false,
    scrollY: false,
    header:{
    	complexColumns:[
    		{
    		header:'조건검색',
    		name:'mergeCol',
    		hideChildHeaders:true,
    		childNames:['program','search'],    			
    		},
    	]
    		
    },
    columns:[
    	{
    		header:'업무구분',
    		name:'task',
      		editor:{
      			type: 'select',
      			options:{
      				listItems:[
      					 {
      				            text: 'ACT',
      				            value: 'ACT',
      				          },
      				          {
      				            text: 'BDG',
      				            value: 'BDG',
      				          },
      				          {
      				            text: 'CMT',
      				            value: 'CMT',
      				          },
      				          {
      				            text: 'GAF',
      				            value: 'GAF',
      				          },
      				          {
      				            text: 'IPS',
      				            value: 'IPS',
      				          },
      				          {
        				            text: 'OTC',
        				            value: 'OTC',
        				      },
      				          {
      				            text: 'PER',
      				            value: 'PER',
      				      },
    				       {
    				            text: 'PLN',
    				            value: 'PLN',
    				      },
    				       {
    				            text: 'PMS',
    				            value: 'PMS',
    				      },
    				       {
    				            text: 'PRO',
    				            value:'PRO',
    				      },
    				       {
    				            text: 'PUC',
    				            value: 'PUC',
    				      },
    				       {
    				            text: 'SAL',
    				            value: 'SAL',
    				      },
    				       {
    				            text: 'SAM',
    				            value: 'SAM',
    				      },
    				       {
    				            text: 'SYS',
    				            value: 'SYS',
    				      },
        				          
      				]
      			}
      		}
    	},
    	{
    		header:'조건검색',
    		name:'program',
      		editor:{
      			type: 'select',
      			options:{
      				listItems:[
      					 {
      				            text: '프로그램명',
      				            value: '프로그램명',
      				          },
      				          {
      				            text: '프로그램코드',
      				            value: '프로그램코드',
      				          },
      				          {
        				            text: '경로',
        				            value: '경로',
        				      }, 
      				]
      			}
      		}
    	},
    	{
    		header:'조건검색',
    		name:'search',
            align : 'left',
            editor: 'text',
            validation: {
                dataType: 'text',
            },
    	},
    	{
    		header:'사용',
    		name:'use',
    		editor:{
    			type: 'select',
    			options:{
    				listItems:[
    					 {
    				            text: '사용',
    				            value: '사용'
    				          },
    				          {
    				            text: '사용 안함',
    				            value: '사용 안함'
    				          },
    				]
    			}
    		}
    	},
    ],
});


const selectData = [
	{
		task:"::전체::",
		program:"::전체::",
		search:"",
		use:"::전체::",
	},
];

selectBoxGrid.resetData(selectData);

//list Grid
const listGrid = new Grid({
    el: list,
    minBodyHeight: 40,
    rowHeaders: ['rowNum','checkbox'],
    scrollX: false,
    scrollY: false,
    pageOptions: {
    	useClient: true,
        perPage: 30
      },
    pagination : true,
    columns: [
        {
            header: '상태',
            align : 'center',
            editor: 'text',
            name  : 'state',
            defaultValue:'등록'
        },
    {
        header: '프로그램코드',
        align : 'center',
        editor: 'text',
        name  : 'PGM_CD',
    },
      {
        header: '프로그램명',
        align : 'left',
        editor: 'text',
        name  : 'PGM_NM',
      },
      {
        header: '경로',
        align : 'left',
        editor: 'text',
        name  : 'PGM_PTH_NM',
      },
      {
  		header:'업무구분',
  		name:'BUSI_DIV_CD',
  		editor:{
  			type: 'select',
  			options:{
  				listItems:[
  					 {
  				            text: 'ACT',
  				            value: 'ACT',
  				          },
  				          {
  				            text: 'BDG',
  				            value: 'BDG',
  				          },
  				          {
  				            text: 'CMT',
  				            value: 'CMT',
  				          },
  				          {
  				            text: 'GAF',
  				            value: 'GAF',
  				          },
  				          {
  				            text: 'IPS',
  				            value: 'IPS',
  				          },
  				          {
    				            text: 'OTC',
    				            value: 'OTC',
    				      },
  				          {
  				            text: 'PER',
  				            value: 'PER',
  				      },
				       {
				            text: 'PLN',
				            value: 'PLN',
				      },
				       {
				            text: 'PMS',
				            value: 'PMS',
				      },
				       {
				            text: 'PRO',
				            value:'PRO',
				      },
				       {
				            text: 'PUC',
				            value: 'PUC',
				      },
				       {
				            text: 'SAL',
				            value: 'SAL',
				      },
				       {
				            text: 'SAM',
				            value: 'SAM',
				      },
				       {
				            text: 'SYS',
				            value: 'SYS',
				      },
    				          
  				]
  			}
  		}
  	},
	{
		header:'사용',
		name:'USE_YN',
		editor:{
			type: 'select',
			options:{
				listItems:[
					 {
				            text: '사용',
				            value: '사용'
				          },
				          {
				            text: '사용 안함',
				            value: '사용 안함'
				          },
				]
			}
		}
	},
    ]
  });
  
	
   //Data
   $.ajax({
	   type:"GET",
	   url:"/api/getlist",
	   async:false,
	   success:(data)=>{
		   
		   let pgmCode=[];
		   //pgmCodeList
		   
		   let insertData = [];
		   //insert data 배열
		   
		   let updateData = [];
		   //update data 배열
		   
		   let deleteData = [];
		   //delete data 배열
		   
		   let searchData;
		   //search data 배열
		   
		   let blockAlert = false;
		   // 유호성 검사에 걸릴 경우 저장실패얼럿 막기용 변수;
		   
			let error = false;
			//유효성 검사에 걸릴 경우 저장 막기용 변수
		   
		   //사용여부 문자로 변환
		   data = data.map((value)=>{
			   pgmCode.push(value.PGM_CD);			   
			   return value;
		   })
		   
		   listGrid.resetData(data);
		   listCount.innerText = data.length;
		  
			
			
		   //function
		   
		   //객체 정리 함수
		   const objClean=(firstArr,dataArr)=>{
		 		//필요없는 프로퍼티스 삭제;
				if(Array.isArray(firstArr) && Array.isArray(dataArr)){
		 			let delProps = ["0","rowKey","rowSpanMap","sortKey","uniqueKey","_attributes","_disabledPriority","_relationListItemMap"];
					firstArr.forEach((val)=>{
						delProps.forEach((delval)=>{
							delete val[delval];
						});
						dataArr.push(val);
					});
					}else{
						console.log('인자 타입을 확인해주세요(배열(원본),배열(객체를담을빈배열))');
					}
				}
		   
		   //유효성 검사 함수
			const validation=(arr,check1,check2)=>{
			   if(Array.isArray(arr) && typeof check1 === "string" && typeof check2 === "string"){
				   for(let i = 0; i<arr.length; i++){
						if(arr[i].PGM_CD === null && arr[i].PGM_NM === null && arr[i].PGM_PTH_NM === null){
							alert(check1);
							blockAlert = true;
							error = true;
							break;
						}else if(arr[i].PGM_CD === null || arr[i].PGM_NM === null || arr[i].PGM_PTH_NM === null){
							alert(check2);
							blockAlert = true;
							error = true;
							break;
						}else{
							error = false;
							break;
						} 					   
				   }
			   }else{
				   console.log('인자타입을 확인해주세요(배열,문자열,문자열)')
			   }
		   }
		   
		   //button 
		   //행추가
		   $('#insert').on('click',function(){
		    let rowData = [{state:"등록",PGM_CD: "", PGM_NM: "", PGM_PTH_NM: ""}]	    
			listGrid.prependRow(
				rowData,{focus:true}
			);
		   });
		  
		  //행삭제(체크된 row만)
		  $('#delete').on('click',function(){
			  let addData = listGrid.getCheckedRows();
			  listGrid.removeCheckedRows(true);
			  objClean(addData,deleteData);
			  
			  listGrid.blur(); 
		  })
		  
		 //초기화
		  $('#reset').on('click',function(){
			  listGrid.resetData(data);
			  selectBoxGrid.resetData(selectData);
		  });
		  
		  
		  //조회
		  $('#search').on('click',function(){
			  let data = selectBoxGrid.getData();
	  			new Promise((resolve,reject)=>{
				  if(data.length !== 0){
					  delete data[0]["_attributes"];
					  delete data[0]["rowKey"];
					  
					  //convert
					  
					  //program
					  switch(data[0].program){
					  	case "프로그램명":
					  		data[0].program = 'PGM_NM';
					  		break;
					  	case "프로그램코드":
					  		data[0].program = "PGM_CD";
					  		break;
					  	case "경로":
					  		data[0].program = "PGM_PTH_NM";
					  		break;
					  }
					  
					  //use
					  switch(data[0].use){
					  	case "사용":
					  		data[0].use = "Y";
					  		break;
					  	case "사용 안함":
					  		data[0].use = "N";
					  		break;
					  }
					searchData = data[0];
					resolve(searchData);
			  		}
	  			}).then((data)=>{
	  				console.log(data);
					$.ajax({
		 				 type:"POST",
		 				contentType: "application/json; charset=UTF-8",
		 				 async: false,
		 				 url:"/api/search",
		 				 data:JSON.stringify(data),
		 				 success:function(res){
		 					if(res.length === 0){
		 						alert('조회된 데이터가 없습니다.')
		 					}else{
		 						listGrid.resetData(res);
		 					}
		 				 },error:function(){
		 					 console.log('검색 실패 / searchFail');
		 				 }
					});	
	  			})
		  });
		  
		  
		  //데이터 상태 저장
		  $('#save').on('click',function(){
			let addData = listGrid.getCheckedRows();
			let delCd = [];
			
			const inSortData =()=>{
				let dataSet=[];
				addData.map((val)=>{
					if(!pgmCode.includes(val.PGM_CD)){
						if(val["USE_YN"] === '사용'){
							val["USE_YN"] = "Y";
						}else{
							val["USE_YN"] = "N";
						}
						dataSet.push(val);
					}
				})
				objClean(dataSet,insertData);
			}
			
			inSortData();

			
			
			
			const upSortData =()=>{
				let dataSet=[];
				addData.map((val)=>{
					localStorage.setItem('update',val.PGM_CD);
					if(pgmCode.includes(val.PGM_CD)){
						if(val["USE_YN"] === '사용'){
							val["USE_YN"] = "Y";
						}else{
							val["USE_YN"] = "N";
						}
						dataSet.push(val);
					}
				})
				objClean(dataSet,updateData);
			}
			
			upSortData();
			
			//delete 객체 정리
			if(deleteData.length !==0){
					deleteData.forEach((value)=>{
						delCd.push({PGM_CD:value.PGM_CD});
					});
					console.log(delCd);
					error = false;
			}
				
			
			//insert 유효성검사
			if(insertData.length !== 0){
				validation(insertData,"값이 빈 행이 있습니다.","빈 항목값을 확인해주세요.");			
			}
			
			//update 유효성 검사
			if(updateData.length !== 0){
				validation(updateData,"수정된 행 중에 값이 빈 행이 있습니다.","수정된 행 중 빈 항목값을 확인해주세요.");
			}
			
			if(error === false){
				new Promise((resolve,reject)=>{
					
				//insert
				if(insertData.length !== 0){
						$.ajax({
			 				 type:"POST",
			 				 contentType: 'application/json; charset=UTF-8',
			 				 traditional: true,
			 				async: false,
			 				 url:"/api/save",
			 				 data:JSON.stringify(insertData),
			 				 success:function(res){
			 					console.log(res);
			 				 },error:function(){
			 					 error = true;
			 					 console.log('추가 실패 / insertFail');
			 				 }
						});					
				}
				
				if(delCd.length !== 0){
				//delete
					$.ajax({
					   type:"POST",
						contentType: 'application/json; charset=UTF-8',
					   url:"/api/delete",
					   traditional: true,
					   async: false,
					   data:JSON.stringify(delCd),
					   success:function(res){
						   console.log(res);
					   },error:function(){
						   error = true;
						   console.log('삭제 실패 / deleteFail');
					   }
					});					
				}
				
				if(updateData !== 0){
				//update
					$.ajax({
					   type:"POST",
						contentType: 'application/json; charset=UTF-8',
					   url:"/api/update",
					   traditional: true,
					   async: false,
					   data:JSON.stringify(updateData),
					   success:function(res){
						   console.log(res);
					   },error:function(){
						   error = true;
						   console.log('수정 실패 / updateFail');
					   }
					});					
				}
				
				resolve('저장을 성공하였습니다.');
				}).then((val)=>{
					alert(val);
// 					location.reload();
				})
			}else{
				if(blockAlert){
					return null;
				}else{
				alert('저장을 실패하였습니다.')					
				}
			}
			
			
			});
		  
		  //엑셀저장(선택된목록만)
		  $('#excel').on('click',function(){
			  let options = {
		              includeHeader : true,
		              includeHiddenColumns : true,
		              onlySelected : true,
		              fileName: 'TSYS_PGM_List'
		            };
		   listGrid.export('xlsx', options);
		  });
	   },
	   error:(error)=>{console.log("받기실패")}
  });
	</script>
</body>
</html>