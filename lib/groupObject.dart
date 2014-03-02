library groupObject;

import 'package:hub/hub.dart';
import 'package:ds/ds.dart';

abstract class GroupObject extends MapDecorator{
	Groups owner;

	GroupObject(this.owner);

	void init();
	void free(){
		this.owner.free(this);
		this.flush();
	}
}

class Groups{
	final dsList freed = dsList.create();
	final dsList locked = dsList.create();
	var freedit,lockedit;
	Function generator;

	static create(n) => new Groups(n);
	
	Groups(this.generator){
		this.freedit = this.freed.iterator;
		this.lockedit = this.locked.iterator;
	}

	GroupObject make([List a,Map m]){
		var op = Funcs.switchUnless(a,[]);
		var named = Funcs.switchUnless(m,{});

		if(this.freed.isEmpty){
			var pos = [this];
			pos.addAll(op);

			var res = Function.apply(generator,pos,Hub.encryptNamedArguments(named));
			this.locked.add(res);
			return res;
		}

		var group = this.freed.removeHead();
		Function.apply(group.data.init,op,Hub.encryptNamedArguments(named));
		this.locked.add(group.data);
		return group.data;
	}

	void free(GroupObject n){
		var node = this.lockedit.remove(n);
		this.freed.add(node.data);
	}

}


