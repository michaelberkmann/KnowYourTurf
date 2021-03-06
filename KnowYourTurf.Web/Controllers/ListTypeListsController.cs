﻿using System.Web.Mvc;
using KnowYourTurf.Core.Html;
using KnowYourTurf.Web.Grids;
using KnowYourTurf.Web.Models;
using StructureMap;

namespace KnowYourTurf.Web.Controllers
{
    public class ListTypeListController : AdminController
    {
        private readonly IPhotoCategoryListGrid _photoCategoryListGrid;
        private readonly IDocumentCategoryListGrid _documentCategoryListGrid;
        private readonly IEventTypeListGrid _eventTypeListGrid;
        private readonly ITaskTypeListGrid _taskTypeListGrid;

        public ListTypeListController(
            IEventTypeListGrid eventTypeListGrid,
            ITaskTypeListGrid taskTypeListGrid,
            IPhotoCategoryListGrid photoCategoryListGrid,
            IDocumentCategoryListGrid documentCategoryListGrid)
        {
            _eventTypeListGrid = eventTypeListGrid;
            _taskTypeListGrid = taskTypeListGrid;
            _photoCategoryListGrid = photoCategoryListGrid;
            _documentCategoryListGrid = documentCategoryListGrid;
        }

        public ActionResult ListType()
        {
            var gridUrlET = UrlContext.GetUrlForAction<EventTypeController>(x => x.ListTypes(null));
            var gridUrlTT = UrlContext.GetUrlForAction<TaskTypeController>(x => x.ListTypes(null));
            var gridUrlDC = UrlContext.GetUrlForAction<DocumentCategoryController>(x => x.ListTypes(null));
            var gridUrlPC = UrlContext.GetUrlForAction<PhotoCategoryController>(x => x.ListTypes(null));
            ListTypeListViewModel model = new ListTypeListViewModel()
                                              {
                                                  AddEditUrlET = UrlContext.GetUrlForAction<EventTypeController>(x => x.AddUpdate(null)),
                                                  AddEditUrlTT = UrlContext.GetUrlForAction<TaskTypeController>(x => x.AddUpdate(null)),
                                                  AddEditUrlDC = UrlContext.GetUrlForAction<DocumentCategoryController>(x => x.AddUpdate(null)),
                                                  AddEditUrlPC = UrlContext.GetUrlForAction<PhotoCategoryController>(x => x.AddUpdate(null)),
                                                  ListDefinition = _eventTypeListGrid.GetGridDefinition(gridUrlET, WebLocalizationKeys.EVENT_TYPES),
                                                  ListDefinitionTT = _taskTypeListGrid.GetGridDefinition(gridUrlTT, WebLocalizationKeys.TASK_TYPES),
                                                  ListDefinitionDC = _documentCategoryListGrid.GetGridDefinition(gridUrlDC, WebLocalizationKeys.DOCUMENT_CATEGORIES),
                                                  ListDefinitionPC = _photoCategoryListGrid.GetGridDefinition(gridUrlPC, WebLocalizationKeys.PHOTO_CATEGORIES),
                                                  PopupTitleET = WebLocalizationKeys.EVENT_INFORMATION.ToString(),
                                                  PopupTitleTT = WebLocalizationKeys.TASK_INFORMATION.ToString(),
                                                  PopupTitlePC = WebLocalizationKeys.PHOTO_CATEGORY_INFORMATION.ToString(),
                                                  PopupTitleDC = WebLocalizationKeys.DOCUMENT_CATEGORY_INFORMATION.ToString()
                                              };
            return View(model);
        }
    }
}