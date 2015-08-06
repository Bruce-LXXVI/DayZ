<?php


class Lexer {
	protected static $_terminals = array(
			// Kommentare
			"#^\/\/.*$#m" => "T_LINEREMARK",
			"#^\/\*.*\*\/#sU" => "T_BLOCKREMARK",

			// Quotes
			"#^\".*\"#sU" => "T_OPASSIGN",
			"#^\;#" => "T_SEMIKOLON",
			"#^\,#" => "T_KOMMA",
			
			// Operators
			"#^\=#" => "T_OPASSIGN",
			"#^\[\]#" => "T_OPARRAY",
			
			// Blöcke
			"/^\{/" => "T_CURLYSTART",
			"/^\}/" => "T_CURLYEND",
				
			"#^class#" => "T_CLASS",
			"#^\s+#s" => "T_WHITESPACE",
			"#^[+-]?(\d*\.\d+|\d+\.\d*)#" => "T_FLOAT",
			"#^[+-]?\d+#" => "T_NUMBER",
			"#^\w+#" => "T_IDENTIFIER",
	);
	
	
	public static function run($source) {
		$line=1;
		$aOffset2Line=array();
		for($i=0; $i < strlen($source); $i++)
		{ 
			$aOffset2Line[$i]=$line;
			if($source[$i] == "\n") $line++;
		}
		
		
		$tokens = array();
	
		//foreach($source as $number => $line) {
			$offset = 0;
			while($offset < strlen($source)) {
				$result = static::_match($source, $aOffset2Line[$offset], $offset);
				if($result === false) {
					throw new Exception("Unable to parse line " . ($aOffset2Line[$offset]) . ".");
				}
				$tokens[] = $result;
				$offset += strlen($result['match']);
			}
		//}
	
		return $tokens;
	}
	
	
	protected static function _match($line, $number, $offset) {
		$string = substr($line, $offset);
	
		foreach(static::$_terminals as $pattern => $name) {
			if(preg_match($pattern, $string, $matches)) {
				@static::$counters[$name]++;
				@$depth=static::$counters['T_CURLYSTART'] - static::$counters['T_CURLYEND'];
				if($name != 'T_WHITESPACE')
					echo 'Line ' . $number . ' depth=' . $depth . ': ' . $name . ' >' . $matches[0] . '<' . PHP_EOL;
				
				return array(
						'match' => $matches[0],
						'token' => $name,
						'line' => $number,
						'depth' => $depth
				);
			}
		}
	
		return false;
	}
	
	
	public static $counters=array();
	
}





class Parser
{
	public static function run($source)
	{
		$result=null;
		$active=null;
		foreach($source as $key => $token)
		{
			
			if($active===null)
			{
			
				switch($token['token'])
				{
					case "T_LINEREMARK":
					case "T_BLOCKREMARK":
					case "T_WHITESPACE":
						// Do nothing with whitespace
						break;
				
					case "T_CLASS":
						$active=new Parser_Class();
						break;
					
					
					default:
						echo 'Unbekanntes Token: ' . $token['token'] . PHP_EOL;
						break;
				}
			} else
			{
				$ret=$active->run(array($token));
				$result[]=$ret;
			}
		}
		return $result;
	}
}



class Parser_Class extends Parser
{
	
}



//$input=file_get_contents('CfgTownGeneratorDefault.hpp');
$input=file_get_contents('CfgChernarusPlus.hpp');
$result = Lexer::run($input);
//var_dump(Lexer::$counters);


$result = Parser::run($result);
print_r($result);

/*
$f=fopen('CfgChernarusPlus.hpp', 'r');

while (false !== ($char = fgetc($f)))
{
	if( trim($char) != '' )
	{	
		echo $char;
	}
}

fclose($f);
*/
