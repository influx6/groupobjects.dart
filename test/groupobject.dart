library specs;

import 'package:group_object/group_object.dart';

class Radish extends GroupObject{

	static create(n) => new Radish(n);

	Radish(n): super(n);

	void init(String type,int weight){
		this.add('type',type);
		this.add('weight',weight);
	}
	
	String toString(){
	  return "Radish type ${this.get('type')} weight ${this.get('weight')}";
	}
}

void main(){

	var radishes = Groups.create((group,type,weight){
		var rad = Radish.create(group);
		rad.init(type,weight);
		return rad;
	});

	var red = radishes.make(['red',10]);
	print(red);
	var green = radishes.make(['green',22]);
	print(green);
	green.free();
	
	var blue = radishes.make(['blue',21]);
	print(blue);
	assert(blue == green);
	
	radishes.destroy();
	
}
