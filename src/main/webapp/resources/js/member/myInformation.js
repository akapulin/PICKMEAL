/*
$(window).ready(function(){
	$('')
})
*/

$('#changePasswdBtn').on('click', function(){
	console.log("울랄라...");
	$(this).hide();
	$('#originPw').val('');
	$("#newPw").val('');
	$("#checkNewPw").val('');
	$("#checkOriginPwWrap").show();
})

$(document).on('click', "#checkOriginPasswdBtn", function(e){
	e.preventDefault();
	let originPw = $('#originPw').val();
	console.log(originPw);
	
	$.ajax({
		url: getContextPath() + "/checkOriginPw",
		type: "POST",
		data: {"originPw" : originPw},
		dataType: 'text',
		contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
		success: function(data) {
			console.log("확인하고 돌아옴.");
			console.log(data);
			
			if(data == 'S'){
				$("#checkOriginPwWrap").hide();
				$("#changePwWrap").show();
				
				$("#changePwBtn").on('click', function(){
					let newPw = $("#newPw").val();
					let checkNewPw = $("#checkNewPw").val();
					
					console.log(newPw);
					console.log(checkNewPw);
					
					if(newPw.length < 4 || newPw.length > 20){
						Swal.fire({
							icon: 'error',
							title: '입력 오류',
							text: '4글자 이상 20글자 이내로 입력해주세요',
							confirmButtonColor: '#b7cae1',
						})	
						$("#newPw").val('');
						$("#checkNewPw").val('');
					}
					else if(newPw != checkNewPw){
						//alert("입력한 비밀번호가 같지 않습니다. 다시 입력해주세요");
						Swal.fire({
							icon: 'error',
							title: '입력 오류',
							text: '입력한 비밀번호가 같지 않습니다. 다시 입력해주세요',
							confirmButtonColor: '#b7cae1',
						})
						
						$("#newPw").val('');
						console.log(newPw);
						$("#checkNewPw").val('');
						console.log(checkNewPw);
					}else if(newPw === '' && checkNewPw === ''){
						//alert("변경할 비밀번호를 입력해주세요.");
						Swal.fire({
							icon: 'error',
							title: '입력 오류',
							text: '변경할 비밀번호를 입력해주세요.',
							confirmButtonColor: '#b7cae1',
						})
					}
					else{
						$.ajax({
							url: getContextPath() + "/changePw",
							type: "POST",
							data: {"newPw" : newPw},
							dataType: 'text',
							success: function(){
								Swal.fire({
									icon: 'success',
									title: '비밀번호 변경이 완료되었습니다',
									showConfirmButton: false,
									timer: 2500
								})
								$('#changePwWrap').hide();
								$('#changePasswdBtn').show();
								
							},
							error: function(){
								console.log("hi fail");	
							}
						})
					}
				})	
			} else{ // 원래 비밀번호를 잘못 입력했을 경우
				Swal.fire({
					icon: 'error',
					title: '입력 오류',
					text: '비밀번호가 일치하지 않습니다.',
					confirmButtonColor: '#b7cae1',
				})
				$('#originPw').val('');
			}
		}
	});
	
})

$("#deleteBtn").on('click', function(){
	Swal.fire({
	title: '회원 탈퇴를 하시겠습니까?',
	text: "이 작업은 되돌릴 수 없으며 동일 아이디로 재가입할 수 없습니다. ",
	icon: 'warning',
	showCancelButton: true,
	confirmButtonColor: '#a9a9a9',
	cancelButtonColor: '#a9a9a9',
	confirmButtonText: '네',
	cancelButtonText: '아니요'
}).then((result) => {
  if (result.isConfirmed) {
    Swal.fire(
      '회원 탈퇴 되었습니다.',
      '그간 밥찡코를 이용해주셔서 감사합니다',
      'success'
    )

	$.ajax({
		url: getContextPath() + "/deleteMember",
		type: "GET",
		/*data: {"newPw" : newPw},
		dataType: 'text',*/
		success: function(){
			console.log("delete success");
					
			let deleteForm = document.deleteForm;
			deleteForm.submit();
			/*
			$.ajax({
				url: "signOutMember",
				type: "GET",
				success: function(){
					console.log("회원 탈퇴 후 자동 로그아웃 되기");
				}
			})*/
		},
		error: function(){
			console.log("delete fail");	
		}
	})
	
  }
})
})
