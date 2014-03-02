library specs;

import 'package:groupObject/groupObject.dart';

class Radish extends GroupObject{

	static create(n) => new Radish(n);

	Radish(n): super(n);

	void init(String type,int weight){
		this.add('type',type);
		this.add('weight',weight);
	}
}

void main(){

	var radishes = Groups.create((group,type,weight){
		var rad = Radish.create(group);
		rad.init(type,weight);
		return rad;
	});

	var red = radishes.make(['red',10]);
	var green = radishes.make(['green',22]);
	green.free();
	var blue = radishes.make(['blue',21]);
	assert(blue == green);
}
