var Action = can.Model.extend({
  findAll: 'GET /api/action',
  findOne: 'GET /api/action/{id}',
  update: 'PUT /api/action/{id}',
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
    }
  }
});

$("#content").html(can.view("appMustache", { }));
