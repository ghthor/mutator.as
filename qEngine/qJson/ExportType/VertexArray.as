﻿package qEngine.qJson.ExportType {	import flash.display.MovieClip;	import qEngine.qJson.ExportType.Vertex;		/**	 * ...	 * @author ...	 */	public class VertexArray {		public var array:Array = new Array();				public function addVertex(vert:Vertex):Boolean {			if (array[vert.index] != null) {				trace("index taken: " + vert.index);				return false;			}			array[vert.index] = vert;			return true;		}				public function at(index:int):Vertex {			return array[index];		}				public function toJsonString():String {			var str:String = "";			var i:int = 0;						for (; i < array.length - 1; i++) {				if(!(array[i] is Vertex)) {					trace(i + " isn't vertex!!");					continue;				}				str+=array[i].toJsonString()				str+= ",\n"			}			str+=array[i].toJsonString()			return str		}	}	}