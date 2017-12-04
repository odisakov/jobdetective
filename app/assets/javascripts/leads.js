
  document.addEventListener('DOMContentLoaded', function () {

    var docElem = document.documentElement;
    var board = document.querySelector('.board');
    var itemContainers = Array.prototype.slice.call(document.querySelectorAll('.board-column-content'));
    var columnGrids = [];
    var dragCounter = 0;
    var boardGrid;

    function updateItemsStatus(item, columnGrids){
      var gridId = item._gridId;
      var targetGrid = columnGrids.filter(function(grid) { return grid._id === gridId })[0];
      var leadStatus = targetGrid.getElement().dataset.leadStatus;
      var leadId = item.getElement().dataset.leadId;

      $.ajax({
        type: "PUT",
        dataType: "script",
        url: '/leads/' + leadId,
        contentType: 'application/json',
        data: JSON.stringify({status: leadStatus})
      })
    }

    itemContainers.forEach(function (container) {

      var muuri = new Muuri(container, {
        items: '.board-item',
        layoutDuration: 400,
        layoutEasing: 'ease',
        dragEnabled: true,
        dragSort: function () {
          return columnGrids;
        },
        dragSortInterval: 0,
        dragContainer: document.body,
        dragReleaseDuration: 400,
        dragReleaseEasing: 'ease'
      })
      .on('dragStart', function (item) {
        ++dragCounter;
        docElem.classList.add('dragging');
        item.getElement().style.width = item.getWidth() + 'px';
        item.getElement().style.height = item.getHeight() + 'px';
      })
      .on('dragEnd', function (item) {
        if (--dragCounter < 1) {
          docElem.classList.remove('dragging');
        }
      })
      .on('dragReleaseEnd', function (item) {
        item.getElement().style.width = '';
        item.getElement().style.height = '';
        columnGrids.forEach(function (muuri) {
          muuri.refreshItems();
        });

        // update status
        updateItemsStatus(item, columnGrids);
      })
      .on('layoutStart', function () {
        boardGrid.refreshItems().layout();
      });

      columnGrids.push(muuri);

    });

    boardGrid = new Muuri(board, {
      layoutDuration: 400,
      layoutEasing: 'ease',
      dragEnabled: false,
      dragSortInterval: 0,
      dragStartPredicate: {
        handle: '.board-column-header'
      },
      dragReleaseDuration: 400,
      dragReleaseEasing: 'ease'
    });

  });

// var gridB = new Muuri('.board-column-working', {
//     items: '.board-item',
//     dragEnabled: true
//   });

// var gridC = new Muuri('.board-column-done', {
//     items: '.board-item',
//     dragEnabled: true
//   });




