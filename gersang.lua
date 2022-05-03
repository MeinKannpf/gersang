local SCREEN_WIDTH = 1920  -- 가로비율
local SCREEN_HIGHT = 1080  -- 세로비율
local TOLERANCE = 5	    -- 마우스 이동속도 1~4 적당 높으면 정확도 떨어져서 칼퇴 실패율 높아짐
local INPUT_DELAY = 8     -- 동작 사이사이 딜레이


local function PressAndReleaseMouseButton(button)
	PressMouseButton(button)
	Sleep(INPUT_DELAY)
	ReleaseMouseButton(button)
	Sleep(INPUT_DELAY)
end -- end function


local function PressAndReleaseKey(keyname)
	PressKey(keyname)
	Sleep(INPUT_DELAY)
	ReleaseKey(keyname)
	Sleep(INPUT_DELAY)
end -- end function

local function UseSkillCtrl(key,cnt)
	PressKey("lctrl")
	Sleep(INPUT_DELAY)
	
	while cnt > 0 do
		PressAndReleaseKey(key)
		cnt = cnt - 1
	end --end while

	ReleaseKey("lctrl")
	Sleep(INPUT_DELAY)
end -- end function

local function GetCurrentPixel()
	local coord_x_64K, coord_y_64K = GetMousePosition()
	Sleep(1)
	local coord_x_pixel = math.floor((coord_x_64K + (0.5 + 2^-16)) * (SCREEN_WIDTH - 1) / 65535)
	local coord_y_pixel = math.floor((coord_y_64K + (0.5 + 2^-16)) * (SCREEN_HIGHT - 1) / 65535)
	return coord_x_pixel, coord_y_pixel
end -- end function


local function MoveMousePixel(target_x_pixel,target_y_pixel,num)
	
	local current_x_pixel, current_y_pixel, x, y
	local maximum_cnt = SCREEN_WIDTH
  
	while true do
		current_x_pixel, current_y_pixel = GetCurrentPixel()

		if current_x_pixel - target_x_pixel > TOLERANCE then
			x = -1
		elseif target_x_pixel- current_x_pixel > TOLERANCE then
			x = 1
		else
			x = 0
 		end -- if end
	
		if current_y_pixel - target_y_pixel > TOLERANCE then
			y = -1
		elseif target_y_pixel - current_y_pixel > TOLERANCE then
			y = 1
		else
			y = 0
		end
	
	
		MoveMouseRelative(x * (TOLERANCE+1) , y * (TOLERANCE+1) )
		maximum_cnt = maximum_cnt - 1
	
	
		if (maximum_cnt < 0 or (x==0 and y==0)) and num==1 then
	 		PressKey("escape")
	 		ReleaseKey("escape")
	 		Sleep(INPUT_DELAY)
			PressAndReleaseMouseButton(1)
			PressAndReleaseMouseButton(1)
			PressKey("escape")
			ReleaseKey("escape")
			break
		elseif (maximum_cnt < 0 or (x==0 and y==0)) and num==2 then
			PressAndReleaseKey("1")				-- !!! 격수 부대지정 하신 번호로 변경하세요
			PressAndReleaseKey("1")				-- !!! 격수 부대지정 하신 번호로 변경하세요
			PressAndReleaseKey("4")				-- !!! 도술사 부대지정 하신 번호로 변경하세요
			PressAndReleaseMouseButton(3)
			PressAndReleaseKey("1")				-- !!! 격수 부대지정 하신 번호로 변경하세요
			break
		end --end if
	end -- end while
	Sleep(FUCTION_DELAY)
end -- end function


local function Retreat(x,y,num)
	MoveMousePixel(x,y,num)
end --end function



--------------------------------설정 변경 ---------------------------------
																		
function OnEvent(event, arg)	
	if event == "MOUSE_BUTTON_RELEASED" and arg == 2 then	-- 우클릭시 좌표 띄워주는 코드
		OutputLogMessage("(%d, %d)\n",GetCurrentPixel())	
	end 		
																																										
	if event == "MOUSE_BUTTON_RELEASED" and arg == 3 then  -- 본진홀드 , 주박OR허영, 뇌전주 , 격수로 전환	
		
		PressAndReleaseKey("tilde")	-- `키 누름	(본진) 본진홀드 필요없으면 지워주세요
		PressAndReleaseKey("h")	-- 본진홀드

		PressAndReleaseKey("2")	-- 2 뇌공
		UseSkillCtrl("f",1)
		UseSkillCtrl("t",2)	-- W 누름 , 24회 반복	(뇌공 스킬반복)   


		PressAndReleaseKey("3")	-- 3번 누름 (본캐) 
		UseSkillCtrl("t",2)   -- T 서총총
		UseSkillCtrl("b",3)
		
		PressAndReleaseKey("4")	-- 2 누름 (음양사)
		UseSkillCtrl("r",4)
		UseSkillCtrl("h",1)

		PressAndReleaseKey("5")	-- 5번 누름 (도철) 
		UseSkillCtrl("r",4)	-- R 누름 (주박청음 시전)


		PressAndReleaseKey("2")	-- 2 누름 (뇌공)
		UseSkillCtrl("f",24)	-- W 누름 , 24회 반복	(뇌공 스킬반복)   
		UseSkillCtrl("Z",20)	
		


	
		PressAndReleaseKey("1")	
	end

	if event == "G_RELEASED" and arg == 2 then  -- 본진홀드 , 주박OR허영, 뇌전주 , 격수로 전환	
		
		PressAndReleaseKey("tilde")	-- `키 누름	(본진) 본진홀드 필요없으면 지워주세요
		PressAndReleaseKey("h")	-- 본진홀드

		PressAndReleaseKey("2")	-- 2 뇌공
		UseSkillCtrl("f",1)
		UseSkillCtrl("t",2)	-- W 누름 , 24회 반복	(뇌공 스킬반복)   


		PressAndReleaseKey("3")	-- 3번 누름 (본캐) 
		UseSkillCtrl("t",2)   -- T 서총총
		UseSkillCtrl("b",3)
		
		PressAndReleaseKey("4")	-- 2 누름 (음양사)
		UseSkillCtrl("r",4)
		UseSkillCtrl("h",1)

		PressAndReleaseKey("5")	-- 5번 누름 (도철) 
		UseSkillCtrl("r",4)	-- R 누름 (주박청음 시전)


		PressAndReleaseKey("2")	-- 2 누름 (뇌공)
		UseSkillCtrl("f",24)	-- W 누름 , 24회 반복	(뇌공 스킬반복)   
		UseSkillCtrl("Z",20)	
		


	
		PressAndReleaseKey("1")	
	end

	if event == "MOUSE_BUTTON_RELEASED" and arg == 4 then	-- 스킬난사
		UseSkillCtrl("r",5) -----------지국
		PressAndReleaseKey("0")	-- 난다데비
		UseSkillCtrl("r",2)
		PressAndReleaseKey("minus")	-- 각세스
		UseSkillCtrl("b",2)
		PressAndReleaseKey("7")	-- 파동
		UseSkillCtrl("r",3)
		PressAndReleaseKey("6")	-- 군다리
		UseSkillCtrl("r",5)
		UseSkillCtrl("h",1)
		PressAndReleaseKey("8")	-- 노부
		UseSkillCtrl("r",5)
		UseSkillCtrl("h",1)
		PressAndReleaseKey("9")	-- 초선(음양사 OR 염력사) 
		UseSkillCtrl("f",5)
		UseSkillCtrl("h",1)
		PressAndReleaseKey("1")       --지국
			end


	if event == "MOUSE_BUTTON_RELEASED" and arg == 6 then	-- 도술사로 격수 마나 채우기
		PressAndReleaseKey("7")	-- 5번 누름  파동(음양사 OR 염력사) 
		UseSkillCtrl("r",4)
		PressAndReleaseKey("1") 

	end	

	if event == "MOUSE_BUTTON_RELEASED" and arg == 7 then	-- 아래쪽 키
		UseSkillCtrl("r",5)
		PressAndReleaseKey("6")	-- 5번 누름  파동(음양사 OR 염력사) 
		UseSkillCtrl("r",2)
		UseSkillCtrl("h",1)
		PressAndReleaseKey("7")	-- 5번 누름  파동(음양사 OR 염력사) 
		UseSkillCtrl("r",3)
		PressAndReleaseKey("8")	-- 5번 누름 (음양사 OR 염력사) 
		UseSkillCtrl("r",2)
		UseSkillCtrl("h",1)
		PressAndReleaseKey("9")	-- 5번 누름 (음양사 OR 염력사) 
		UseSkillCtrl("f",5)
		UseSkillCtrl("h",1)
		PressAndReleaseKey("0")	-- 5번 누름  파동(음양사 OR 염력사) 
		UseSkillCtrl("r",2)
		PressAndReleaseKey("1")       --지국

	end	

	if event == "MOUSE_BUTTON_RELEASED" and arg == 8 then	-- 라시야
		PressAndReleaseKey("5")
		PressAndReleaseKey("r",3)
		PressAndReleaseKey("0")	-- 1번 누름 (음양사 OR 염력사) 
		UseSkillCtrl("G",10)	-- Q버튼 , 7회 반복 
	end	

	if event == "MOUSE_BUTTON_RELEASED" and arg == 9 then	-- 도술사로 격수 마나 채우기
		PressAndReleaseKey("3")	-- 1번 누름 (음양사 OR 염력사) 
		PressAndReleaseKey("G",2)
	end	

	if event == "MOUSE_BUTTON_RELEASED" and arg == 10 then	-- 도술사로 격수 마나 채우기
		PressAndReleaseKey("5")
		PressAndReleaseKey("r",1)
		PressAndReleaseKey("0")	-- 1번 누름 (음양사 OR 염력사) 
		UseSkillCtrl("G",10)
	
	end	

	if event == "MOUSE_BUTTON_RELEASED" and arg == 11 then	-- 도술사로 격수 마나 채우기
		PressAndReleaseKey("6")	-- Q버튼 , 7회 반복 

	end	


	if event == "MOUSE_BUTTON_RELEASED" and arg == 5 then	-- 칼퇴 건들거없음
		Retreat(964,590,1)	
		
	end
	

--------------------------------설정 변경 --------------------------------- 키보드


if event == "G_RELEASED" and arg == 3 then	-- 스킬난사
		UseSkillCtrl("r",7)
		PressAndReleaseKey("0")	-- 난다데비
		UseSkillCtrl("r",2)
		PressAndReleaseKey("minus")	-- 각세스
		UseSkillCtrl("b",3)
		PressAndReleaseKey("7")	-- 군다리
		UseSkillCtrl("r",5)
		PressAndReleaseKey("6")	-- 파동
		UseSkillCtrl("r",3)
		UseSkillCtrl("h",1)
		PressAndReleaseKey("8")	--노부
		UseSkillCtrl("r",5)
		UseSkillCtrl("h",1)
		PressAndReleaseKey("9")	-- 초선
		UseSkillCtrl("f",5)
		UseSkillCtrl("h",1)
		PressAndReleaseKey("1")       --지국
	end


	if event == "G_RELEASED" and arg ==7 then	-- 군다리
		PressAndReleaseKey("7")	-- 5번 누름  파동(음양사 OR 염력사) 
		UseSkillCtrl("r",4)
		PressAndReleaseKey("1") 

	end	

	if event == "G_RELEASED" and arg == 15 then	-- 아래쪽 키
		UseSkillCtrl("r",5)
		PressAndReleaseKey("6")	-- 5번 누름  파동(음양사 OR 염력사) 
		UseSkillCtrl("r",2)
		UseSkillCtrl("h",1)	
		UseSkillCtrl("h",1)
		PressAndReleaseKey("9")	-- 5번 누름 (음양사 OR 염력사) 
		UseSkillCtrl("f",5)
		UseSkillCtrl("h",1)
		PressAndReleaseKey("0")	-- 5번 누름  파동(음양사 OR 염력사) 
		UseSkillCtrl("r",2)
		PressAndReleaseKey("1")       --지국

	end	

	if event == "G_RELEASED" and arg == 9 then	-- 주박
		PressAndReleaseKey("5")
		PressAndReleaseKey("r",3)
		PressAndReleaseKey("0")	-- 1번 누름 (음양사 OR 염력사) 
		UseSkillCtrl("G",10)	-- Q버튼 , 7회 반복 
	end	

	if event == "G_RELEASED" and arg == 9 then	-- 도술사로 격수 마나 채우기
		PressAndReleaseKey("3")	-- 1번 누름 (음양사 OR 염력사) 
		PressAndReleaseKey("G",2)
	end	

	if event == "G_RELEASED" and arg == 10 then	-- 도술사로 격수 마나 채우기
		PressAndReleaseKey("5")
		PressAndReleaseKey("r",1)
		PressAndReleaseKey("0")	-- 1번 누름 (음양사 OR 염력사) 
		UseSkillCtrl("G",10)
	
	end	

	if event == "G_RELEASED" and arg == 11 then	-- 도술사로 격수 마나 채우기
		PressAndReleaseKey("6")	-- Q버튼 , 7회 반복 

	end	


	if event == "G_RELEASED" and arg == 1  then	-- 칼퇴 건들거없음
		Retreat(964,590,1)	
		
	end


end
