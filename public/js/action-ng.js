(function(app) {
  // define factories, controllers, etc. on app
  app.factory("Action", function($resource) {
    return $resource("/api/action/:id", {id:"@id"});
  });
  app.factory("actions", function(Action) {
    return Action.query();
  });
  app.factory("deleteAction", function(actions) {
    return function(action) {
      var index = actions.indexOf(action);
      action.$delete();
      actions.splice(index, 1);
    };
  });
  app.service("state", function(Action) {
    this.formAction = {action:new Action()};
    this.clearForm = function() {
      this.formAction.action = new Action();
    };
  });
  app.factory("editAction", function(state) {
    return function(action) {
      state.formAction.action = action;
    };
  });
  app.factory("saveAction", function(actions, state) {
    return function(action) {
      if (!action.id) {
        actions.push(action);
      }
      action.$save();
      state.clearForm();
    };
  });
  app.controller("ActionListController",
  /*
    function($scope, actions) {
      $scope.actions = actions;
    }
  */
    function($scope, actions, deleteAction, editAction) {
      $scope.actions = actions;
      $scope.deleteAction = deleteAction;
      $scope.editAction = editAction;
    }
  );
  app.controller("ActionFormController",
    function($scope, state, actions, saveAction) {
      $scope.formAction = state.formAction;
      $scope.saveAction = saveAction;
      $scope.clearForm = state.clearForm;
    }
  );
})(
  angular.module("appAction", [])
);
