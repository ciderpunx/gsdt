var Action = can.Model.extend({
  findAll: 'GET /api/action',
  findOne: 'GET /api/action/{id}',
  update: 'PUT /api/action/{id}',
  create: 'POST /api/action/create',
  destroy: 'DELETE /api/action/{id}'
}, {});

can.Component.extend({
  tag: "actions-app",
  scope: {
    selectedAction: null,
    actions: new Action.List({}),
    select: function(a){
      this.attr('selectedAction', a);
    },
    save: function(a) {
      a.save();
      this.removeAttr('selectedAction');
    },
		create: function(a) {
			act = new Action({
				title: this.attr('title'),
				status: this.attr('status'),
				body: this.attr('body')
			});
			act.save();
		}
	}/*,
	events: {
		/* When a new Action has been created, add it to the actions list
			'{actions-app} created': function (Construct, ev, action) {
				console.log("CREATING!!");
				console.log(this.scope);
				this.scope.attr('selectedAction', action);
			}
	}*/
});

$("#content").html(can.view("appMustache", { }));
