angular.module('JaSON')
    .directive('historyItem', function() {

        return {
            restrict: 'E',
            scope: {
                item: '='
            },
            templateUrl: '/templates/history-item.html',
            link: function(scope) {
                scope.URL = new URL(scope.item.url);
            }
        };

    });