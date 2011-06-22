package lib
{
	import mx.validators.StringValidator;
	import mx.validators.ValidationResult;
	
	public class JuminBunhoValidator extends StringValidator
	{
		public function JuminBunhoValidator()
		{
			super();
		}
		
		
		/**
		 * 입력값은 "811201-1234567" 이나 , "8112011234567"
		 */
		override protected function doValidation(value:Object):Array
		{
			var results:Array = super.doValidation(value);
			
			// 입력필수 설정하였을 경우에는 (required="true") 값을 안넣으면 에러 
			if(results.length != 0)
			{
				return results;
			}
			
			var strRRN:String;
			var keyNum:Array = [2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5];
			var sum:int = 0;
			
			strRRN = (value.toString()).replace(new RegExp("-", "g"), "");
			
			
			// 입력받은 주민번호가 - 기호를 제외한 13자리인지 확인
			if(strRRN.length != 13)
			{
				results.push(new ValidationResult(true, null, "Error", "13자리가 아닙니다."));
				return results;
			}
			else
			{
				for(var i:int=0; i<12; i++)
				{
					sum += parseInt(strRRN.substr(i, 1)) * keyNum[i];
					// 0~12번째 자리의 값을 각각 키값으로 곱하여 모두 합산한다.
				}
				
				var strRRNCheckNum:int = parseInt(strRRN.substr(12, 1));	// 주민번호의 13번째 숫자
				var caculateCheckNum:int = (11-(sum%11))%10;				// 실제 계산한 숫자
				
				// 주민번호 13번째 숫자가 실제 계산값과 맞는지 확인
				if(strRRNCheckNum != caculateCheckNum)
				{
					results.push(new ValidationResult(true, null, "Error", "잘못된 주민등록번호입니다."));
					return results;
				}
			}
			
			return results;
		}		
	}
}