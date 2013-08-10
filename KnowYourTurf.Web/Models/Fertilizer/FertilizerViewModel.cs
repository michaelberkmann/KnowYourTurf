﻿using System.Collections.Generic;
using CC.Core.CoreViewModelAndDTOs;
using CC.Core.CustomAttributes;
using Castle.Components.Validator;
using KnowYourTurf.Core;

namespace KnowYourTurf.Web.Models.Fertilizer
{
    public class FertilizerViewModel:ViewModel
    {
        [ValidateNonEmpty]
        public string Name { get; set; }
        [TextArea]
        public string Description { get; set; }
        [TextArea]
        public string Notes { get; set; }
        [ValidateNonEmpty, ValidateDouble]
        public double N { get; set; }
        [ValidateNonEmpty, ValidateDouble]
        public double P { get; set; }
        [ValidateNonEmpty, ValidateDouble]
        public double K { get; set; }
        public string _documentGridUrl { get; set; }
        public string _photoGridUrl { get; set; }
        public IEnumerable<PhotoDto> _Photos { get; set; }

        public string _saveUrl { get; set; }

        public string Product { get; set; }
    }
}