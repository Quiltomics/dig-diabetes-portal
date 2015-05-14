// Generated by CoffeeScript 1.9.2
(function() {
    var testApp,
        indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

    testApp = angular.module("ChooserApp", []);


    testApp.directive("columnChooser", function() {
        return {
            restrict: "E",
            scope: false,
            templateUrl: "column-chooser-directive",
            link: function(scope, element, attrs) {
                return scope.refreshMarksGrid = function() {};
            }
        };
    });

    testApp.controller("ChooserController", ["$scope","$http", function($scope, $http) {
        var ancestry, dataset, e, fullTextRegexTokens, j, len, len1, len2, len3, len4, n, o, p, q, ref, ref1, ref2, ref3, ref4, ref5, ref6, root, study;
        root = typeof window !== "undefined" && window !== null ? window : global;
        $scope.$ = $;
        $scope.view = {};
        $scope.view.display = 60;
        $scope.datasets = datasets;
        $scope.ancestries = [];
        $scope.studies = [];
        ref = $scope.datasets;
        for (j = 0, len = ref.length; j < len; j++) {
            dataset = ref[j];
            ref1 = dataset.ancestries;
            for (n = 0, len1 = ref1.length; n < len1; n++) {
                ancestry = ref1[n];
                ref2 = ancestry.collections;
                for (o = 0, len2 = ref2.length; o < len2; o++) {
                    study = ref2[o];
                    if (ref3 = study.name, indexOf.call($scope.studies, ref3) < 0) {
                        $scope.studies.push(study.name);
                    }
                }
            }
        }
        ref4 = $scope.datasets;
        for (p = 0, len3 = ref4.length; p < len3; p++) {
            dataset = ref4[p];
            ref5 = dataset.ancestries;
            for (q = 0, len4 = ref5.length; q < len4; q++) {
                ancestry = ref5[q];
                if (ref6 = ancestry.name, indexOf.call($scope.ancestries, ref6) < 0) {
                    $scope.ancestries.push(ancestry.name);
                }
            }
        }
        $scope.phenotypes = [
            {
                "id": "type_2_diabetes",
                "name": "type_2_diabetes",
                "db_key": "T2D",
                "dataset": "diagram",
                "category": "cardiometabolic "
            }, {
                "id": "fasting_glucose",
                "name": "fasting glucose",
                "db_key": "FastGlu",
                "dataset": "magic",
                "category": "cardiometabolic"
            }, {
                "id": "fasting_insulin",
                "name": "fasting insulin",
                "db_key": "FastIns",
                "dataset": "magic",
                "category": "cardiometabolic"
            }, {
                "id": "fasting proinsulin",
                "name": "fasting proinsulin",
                "db_key": "ProIns",
                "dataset": "magic",
                "category": "cardiometabolic"
            }, {
                "id": "two-hour glucose",
                "name": "two-hour glucose",
                "db_key": "2hrGLU_BMIAdj",
                "dataset": "magic",
                "category": "cardiometabolic"
            }, {
                "id": "two-hour insulin",
                "name": "two-hour insulin",
                "db_key": "2hrIns_BMIAdj",
                "dataset": "magic",
                "category": "cardiometabolic"
            }, {
                "id": "HOMA-IR",
                "name": "HOMA-IR",
                "db_key": "HOMAIR",
                "dataset": "magic",
                "category": "cardiometabolic"
            }, {
                "id": "HOMA-B",
                "name": "HOMA-B",
                "db_key": "HOMAB",
                "dataset": "magic",
                "category": "cardiometabolic"
            }, {
                "id": "HbA1c",
                "name": "HbA1c",
                "db_key": "HbA1c",
                "dataset": "magic",
                "category": "cardiometabolic"
            }, {
                "id": "BMI",
                "name": "BMI",
                "db_key": "BMI",
                "dataset": "giant",
                "category": "cardiometabolic"
            }, {
                "id": "waist-hip ratio",
                "name": "waist-hip ratio",
                "db_key": "WHR",
                "dataset": "giant",
                "category": "cardiometabolic"
            }, {
                "id": "height",
                "name": "height",
                "db_key": "Height",
                "dataset": "giant",
                "category": "cardiometabolic"
            }, {
                "id": "total cholesterol",
                "name": "total cholesterol",
                "db_key": "TC",
                "dataset": "glgc",
                "category": "cardiometabolic"
            }, {
                "id": "hdl_cholesterol",
                "name": "HDL cholesterol",
                "db_key": "HDL",
                "dataset": "glgc",
                "category": "cardiometabolic"
            }, {
                "id": "ldl_cholesterol",
                "name": "LDL cholesterol",
                "db_key": "LDL",
                "dataset": "glgc",
                "category": "cardiometabolic"
            }, {
                "id": "triglycerides",
                "name": "Triglycerides",
                "db_key": "TG",
                "dataset": "glgc",
                "category": "cardiometabolic"
            }, {
                "id": "coronary artery disease",
                "name": "coronary artery disease",
                "db_key": "CAD",
                "dataset": "cardiogram",
                "category": "cardiometabolic"
            }, {
                "id": "chronic kidney disease",
                "name": "chronic kidney disease",
                "db_key": "CKD",
                "dataset": "ckdgen",
                "category": "cardiometabolic"
            }, {
                "id": "eGFR-creat (serum creatinine)",
                "name": "eGFR-creat (serum creatinine)",
                "db_key": "eGFRcrea",
                "dataset": "ckdgen",
                "category": "cardiometabolic"
            }, {
                "id": "eGFR-cys (serum cystatin C)",
                "name": "eGFR-cys (serum cystatin C)",
                "db_key": "eGFRcys",
                "dataset": "ckdgen",
                "category": "cardiometabolic"
            }, {
                "id": "urinary albumin-to-creatinine ratio",
                "name": "urinary albumin-to-creatinine ratio",
                "db_key": "UACR",
                "dataset": "ckdgen",
                "category": "cardiometabolic"
            }, {
                "id": "microalbuminuria",
                "name": "microalbuminuria",
                "db_key": "MA",
                "dataset": "ckdgen",
                "category": "cardiometabolic"
            }, {
                "id": "bip",
                "name": "bipolar disorder",
                "db_key": "BIP",
                "dataset": "pgc",
                "category": "other"
            }, {
                "id": "scz",
                "name": "schizophrenia",
                "db_key": "SCZ",
                "dataset": "pgc",
                "category": "other"
            }, {
                "id": "mdd",
                "name": "major depressive disorder",
                "db_key": "MDD",
                "dataset": "pgc",
                "category": "other"
            }
        ];
        $scope.search = {};
        fullTextRegexTokens = [];
        $scope.search.currentQuery = {};
        $scope.view.showAdvancedSelector = true;
        $scope.getDatasetsFromQueryOLD = function(query) {
            var array, e, len5, r, ref7, ref8;
            array = [];
            ref7 = $scope.flattenTree(tree);
            for (r = 0, len5 = ref7.length; r < len5; r++) {
                dataset = ref7[r];
                try {
                    if ((ref8 = query.phenotype, indexOf.call(dataset.phenotypes, ref8) >= 0) && query.technology === dataset.technology) {
                        array.push(dataset);
                    }
                } catch (_error) {
                    e = _error;
                    continue;
                }
            }
            return array;
        };
        $scope.isThereSearchText = function() {
            if (($scope.search.queryDatasetText == null) || $scope.search.queryDatasetText === '') {
                return false;
            } else {
                return true;
            }
        };
        $scope.getDatasetsFromQuery = function(query) {
            var array, e, element, elementsToRemove, index, k, len5, len6, newarray, r, removed_elements, u, v;
            array = [];
            array = $scope.flattenTree(tree);
            newarray = $scope.flattenTree(tree);
            elementsToRemove = [];
            if (!$.isEmptyObject(query)) {
                for (k in query) {
                    v = query[k];
                    if (!(v !== '')) {
                        continue;
                    }
                    index = 0;
                    for (r = 0, len5 = array.length; r < len5; r++) {
                        dataset = array[r];
                        try {
                            if ((dataset[k] == null) || ($.isArray(dataset[k]) && indexOf.call(dataset[k], v) < 0) || (!$.isArray(dataset[k]) && v !== dataset[k])) {
                                if (indexOf.call(elementsToRemove, index) < 0) {
                                    elementsToRemove.push(index);
                                }
                            } else {
                                index = index;
                            }
                        } catch (_error) {
                            e = _error;
                            console.log("error at " + index + " for " + k + " and value " + v);
                            if (indexOf.call(elementsToRemove, index) < 0) {
                                elementsToRemove.push(index);
                            }
                        }
                        index++;
                    }
                }
                removed_elements = 0;
                elementsToRemove.sort(function(a, b) {
                    return a - b;
                });
                for (u = 0, len6 = elementsToRemove.length; u < len6; u++) {
                    element = elementsToRemove[u];
                    newarray.splice(element - removed_elements, 1);
                    removed_elements++;
                }
            }
            return newarray;
        };
        $scope.toggleItems = function(items, setvalue) {
            var item, len5, r;
            for (r = 0, len5 = items.length; r < len5; r++) {
                item = items[r];
                item.selected = setvalue;
            }
        };
        $scope.toggleItem = function(item) {
            console.log("toggling " + item.name);
            item.selected = (item.selected == null) || item.selected === false ? true : false;
        };
        $scope.datasetFilterFunction = function(dataset) {
            var e, ref7;
            try {
                return (ref7 = $scope.search.currentQuery.phenotype, indexOf.call(dataset.phenotypes, ref7) >= 0) && $scope.checkFilterMatchParent(dataset, $scope.tree, {
                        "technology": $scope.search.currentQuery.technology
                    });
            } catch (_error) {
                e = _error;
                return false;
            }
        };
        $scope.getAllFilters = function(collection, known_filters) {
            var callback, filters;
            filters = {};
            callback = function(node, parent, ctrl) {
                var k, len5, r, v, v_v, value;
                for (k in node) {
                    v = node[k];
                    if (!(k !== "sample_groups" && k !== "name" && k !== "id" && k !== "level" && k !== "selected" && k !== "properties")) {
                        continue;
                    }
                    if (!$.isArray(v)) {
                        v = [v];
                    }
                    for (r = 0, len5 = v.length; r < len5; r++) {
                        v_v = v[r];
                        if (filters[k] == null) {
                            filters[k] = [];
                        }
                        value = angular.isObject(v_v) ? v_v.name : v_v;
                        if (indexOf.call(filters[k], value) < 0) {
                            filters[k].push(value);
                        }
                    }
                }
            };
            t.dfs(collection, {
                "childrenName": "sample_groups"
            }, callback);
            return filters;
        };
        $scope.refineFilters = function(query) {
            var collection, new_filters;
            collection = $scope.getDatasetsFromQuery(query);
            new_filters = $scope.getAllFilters(collection);
            console.log("refined filters to " + (angular.toJson(new_filters)));
            return new_filters;
        };
        $scope.assignAncestries = function(item) {
            var ancestries, k, len5, r, results, v;
            ancestries = [
                {
                    "_ea_": "East Asian"
                }, {
                    "_sa_": "South Asian"
                }, {
                    "_eu_": "European"
                }, {
                    "_aa_": "African American"
                }, {
                    "_hs_": "Hispanic"
                }
            ];
            results = [];
            for (r = 0, len5 = ancestries.length; r < len5; r++) {
                ancestry = ancestries[r];
                results.push((function() {
                    var results1;
                    results1 = [];
                    for (k in ancestry) {
                        v = ancestry[k];
                        if ((item.id != null) && item.id.indexOf(k) > -1) {
                            results1.push(item.ancestry = v);
                        } else {
                            results1.push(void 0);
                        }
                    }
                    return results1;
                })());
            }
            return results;
        };
        $scope.propagateAttributes = function(tree) {
            var attributesToPropagateTracker, excludedAttributes, item, len5, r, recursive;
            attributesToPropagateTracker = [];
            excludedAttributes = ["name", "sample_groups", "id", "level", "$$hashKey", "selected", "properties"];
            recursive = function(object, parent) {
                var e, item, k, len5, len6, r, ref7, u, v, value;
                $scope.assignAncestries(object);
                for (k in parent) {
                    v = parent[k];
                    if (indexOf.call(excludedAttributes, k) < 0) {
                        if (object[k] == null) {
                            object[k] = v;
                        } else {
                            if ($.isArray(object[k]) === false) {
                                object[k] = new Array(object[k]);
                            }
                            if ($.isArray(v) === false) {
                                v = [v];
                            }
                            for (r = 0, len5 = v.length; r < len5; r++) {
                                value = v[r];
                                try {
                                    if (indexOf.call(object[k], value) < 0) {
                                        object[k] = object[k].concat(value);
                                    }
                                } catch (_error) {
                                    e = _error;
                                    console.log("propagation error in " + object.name + " " + k);
                                }
                                if (object[k].length === 1) {
                                    object[k] = object[k][0];
                                }
                            }
                        }
                    }
                }
                if ((object.sample_groups != null) && object.sample_groups.length > 0) {
                    ref7 = object.sample_groups;
                    for (u = 0, len6 = ref7.length; u < len6; u++) {
                        item = ref7[u];
                        recursive(item, object);
                    }
                } else {
                    return;
                }
            };
            if ($.isArray(tree)) {
                for (r = 0, len5 = tree.length; r < len5; r++) {
                    item = tree[r];
                    attributesToPropagateTracker = [];
                    recursive(item, null);
                }
            } else if ($.isPlainObject(tree)) {
                recursive(tree);
            }
            return tree;
        };

        $scope.setColumnFilter = function($columns) {
            console.log($columns);
        };

        $scope.flattenTree = function(tree) {
            var array, callback;
            callback = function(node, parent, control) {
                array.push(node);
            };
            array = [];
            t.dfs(tree, {
                "childrenName": "sample_groups"
            }, callback);
            return array;
        };
        $scope.getNodesAtLevel = function(level, collection) {
            var array, item, len5, r, recursive;
            array = [];
            recursive = function(level, collection) {
                var item, len5, r, ref7;
                if ((collection.level != null) && collection.level === level) {
                    array.push(collection);
                }
                if (collection.sample_groups != null) {
                    ref7 = collection.sample_groups;
                    for (r = 0, len5 = ref7.length; r < len5; r++) {
                        item = ref7[r];
                        recursive(level, item);
                    }
                }
            };
            if ($.isArray(collection)) {
                for (r = 0, len5 = collection.length; r < len5; r++) {
                    item = collection[r];
                    recursive(level, item);
                }
            } else if ($.isPlainObject(collection)) {
                recursive(level, collection);
            }
            return array;
        };
        $scope.getLevels = function(collection) {
            var i, len5, level, r, recursive;
            level = 1;
            recursive = function(item) {
                var i, l, len5, r, ref7;
                if (item.level == null) {
                    item.level = level;
                }
                if (item.sample_groups != null) {
                    level++;
                    l = level;
                    ref7 = item.sample_groups;
                    for (r = 0, len5 = ref7.length; r < len5; r++) {
                        i = ref7[r];
                        level = l;
                        recursive(i);
                    }
                }
            };
            if ($.isArray(collection)) {
                for (r = 0, len5 = collection.length; r < len5; r++) {
                    i = collection[r];
                    level = 1;
                    recursive(i);
                }
            } else if ($.isPlainObject(collection)) {
                recursive(collection);
            }
        };
        $scope.getLevelOLD = function(item, collection) {
            var callback, len5, level, parents, r, thing;
            level = 1;
            parents = [];
            callback = function(node, parent, control) {
                if (control.stop === true) {
                    return;
                }
                if (parent == null) {
                    level = 1;
                    parents = [];
                } else if (indexOf.call(parents, parent) < 0) {
                    parents.push(parent);
                    level++;
                }
                if (node === item) {
                    control.stop = true;
                    node.level = level;
                }
            };
            if ($.isArray(collection)) {
                for (r = 0, len5 = collection.length; r < len5; r++) {
                    thing = collection[r];
                    t.bfs(thing, {
                        "childrenName": "sample_groups"
                    }, callback);
                }
            } else {
                t.bfs(thing, {
                    "childrenName": "sample_groups"
                }, callback);
            }
            return level;
        };
        $scope.view = {};
        $scope.view.highlight = {};
        $scope.view.showFilter = {};
        $scope.checkFilterMatchParent = function(item, collection, filterObject) {
            var callback, doesItMatch, foundAttributes, matchLevel, stop;
            doesItMatch = false;
            matchLevel = 0;
            stop = false;
            foundAttributes = {};
            if ($.isEmptyObject(filterObject)) {
                return true;
            }
            callback = function(node, parent, control) {
                var currentMatch, e, k, v;
                if (stop) {
                    return;
                }
                if (node.level > item.level) {
                    return;
                } else {
                    if (node.level <= matchLevel) {
                        matchLevel = 0;
                        doesItMatch = false;
                        foundAttributes = {};
                    }
                    for (k in filterObject) {
                        v = filterObject[k];
                        if ((!$.isArray(node[k]) && v === node[k]) || ($.isArray(node[k]) && indexOf.call(node[k], v) >= 0)) {
                            foundAttributes[k] = v;
                        }
                    }
                    for (k in filterObject) {
                        v = filterObject[k];
                        try {
                            if (foundAttributes[k] === v && currentMatch !== false) {
                                currentMatch = true;
                            } else {
                                currentMatch = false;
                            }
                        } catch (_error) {
                            e = _error;
                            currentMatch = false;
                        }
                    }
                    if (currentMatch && matchLevel === 0) {
                        matchLevel = node.level;
                    }
                    doesItMatch = currentMatch;
                }
                if (node === item) {
                    stop = true;
                }
            };
            t.dfs(collection, {
                "childrenName": "sample_groups"
            }, callback);
            return doesItMatch;
        };
        $scope.checkFilterMatch = function(item, filterObject) {
            var doesItMatch, e, k, v;
            doesItMatch = true;
            for (k in filterObject) {
                v = filterObject[k];
                if (!((v != null) === true)) {
                    continue;
                }
                if (angular.isObject(item.attributes[k])) {
                    console.log("filtering on object " + (angular.toJson(item.attributes[k])));
                }
                try {
                    if ((item.attributes[k] === v && doesItMatch === true) || (angular.isObject(item.attributes[k]) && item.attributes[k].name === v && doesItMatch === true)) {
                        doesItMatch = true;
                    } else {
                        doesItMatch = false;
                    }
                } catch (_error) {
                    e = _error;
                    console.log("filter error on " + item + " " + k);
                    doesItMatch = false;
                }
            }
            return doesItMatch;
        };
        $scope.setHighlight = function(attribute, value) {
            if ($scope.view.highlight[attribute] === value) {
                $scope.view.highlight = {};
            } else {
                $scope.view.highlight = {};
                $scope.view.highlight[attribute] = value;
            }
        };
        $scope.addFilter = function(attribute, value) {
            $scope.view.showFilter[attribute] = value;
        };
        $scope.removeFilter = function(attribute, value) {
            delete $scope.view.showFilter[attribute];
        };
        $scope.checkAttribute = function(item, attributeObject) {
            var k, v;
            for (k in attributeObject) {
                v = attributeObject[k];
                if ((item.attributes[k] != null) && item.attributes[k] && item.attributes[k] === v) {
                    console.log((item.name + " match on") + v);
                    return true;
                }
            }
            return false;
        };
        $scope.checkIfSelectable = function(item) {
            return true;
        };
        $scope.updateSearchText = function() {
            var fullTextTokens, len5, r, token;
            fullTextTokens = $scope.search.queryDatasetText != null ? $scope.search.queryDatasetText.match(/\w+|".*?"/g) : [];
            fullTextTokens = fullTextTokens != null ? fullTextTokens : [];
            fullTextRegexTokens = [];
            for (r = 0, len5 = fullTextTokens.length; r < len5; r++) {
                token = fullTextTokens[r];
                fullTextRegexTokens.push(new RegExp('\\b' + token.replace(/"/gi, ""), 'i'));
            }
            console.log(fullTextRegexTokens);
            return fullTextRegexTokens;
        };
        $scope.checkSearchTextMatch = function(item) {
            var doesItMatch, e, excludedAttributes, k, len5, r, token, v;
            doesItMatch = false;
            if (fullTextRegexTokens.length === 0) {
                doesItMatch = true;
            }
            excludedAttributes = ["sample_groups", "id", "level", "$$hashKey", "selected", "properties"];
            for (r = 0, len5 = fullTextRegexTokens.length; r < len5; r++) {
                token = fullTextRegexTokens[r];
                try {
                    for (k in item) {
                        v = item[k];
                        if (indexOf.call(excludedAttributes, k) < 0) {
                            if (token.test(v)) {
                                doesItMatch = true;
                            }
                        }
                    }
                } catch (_error) {
                    e = _error;
                    continue;
                }
            }
            return doesItMatch;
        };
        $scope.selectMatches = function(tree, setvalue, attribute, value) {
            var criteria, flat, input, k, len5, r, results, v;
            criteria = {};
            criteria[attribute] = value;
            $scope.getLevels(tree);
            $scope.propagateAttributes(tree);
            flat = $scope.flattenTree(tree);
            results = [];
            for (r = 0, len5 = flat.length; r < len5; r++) {
                input = flat[r];
                results.push((function() {
                    var results1;
                    results1 = [];
                    for (k in criteria) {
                        v = criteria[k];
                        if ((!$.isArray(input[k]) && input[k] === v) || ($.isArray(input[k]) && indexOf.call(input[k], v) >= 0)) {
                            results1.push(input.selected = setvalue);
                        } else {
                            results1.push(void 0);
                        }
                    }
                    return results1;
                })());
            }
            return results;
        };
        $scope.selectMatchesOLD = function(tree, setvalue, attribute, value) {
            var criteria, setChildren;
            criteria = {};
            criteria[attribute] = value;
            setChildren = function(input, setvalue) {
                var child, item, k, len5, len6, r, ref7, u, v;
                if ($.isArray(input)) {
                    for (r = 0, len5 = input.length; r < len5; r++) {
                        item = input[r];
                        setChildren(item, setvalue);
                    }
                } else if ($.isPlainObject(input)) {
                    for (k in criteria) {
                        v = criteria[k];
                        if ((!$.isArray(input[k]) && input[k] === v) || ($.isArray(input[k]) && indexOf.call(input[k], v) >= 0)) {
                            input.selected = setvalue;
                            return;
                        }
                    }
                    if (input.sample_groups != null) {
                        ref7 = input.sample_groups;
                        for (u = 0, len6 = ref7.length; u < len6; u++) {
                            child = ref7[u];
                            setChildren(child, setvalue);
                        }
                    }
                }
            };
            return setChildren(tree, setvalue);
        };
        $scope.resetFilters = function() {
            $scope.search.currentQuery = {};
            $scope.view.filters = $scope.refineFilters($scope.search.currentQuery);
            $scope.queryDatasetText = null;
        };
        $scope.getSelectedSets = function(tree) {
            var set;
            return (function() {
                var len5, r, ref7, results;
                ref7 = $scope.flattenTree(tree);
                results = [];
                for (r = 0, len5 = ref7.length; r < len5; r++) {
                    set = ref7[r];
                    if (set.selected === true) {
                        results.push(set);
                    }
                }
                return results;
            })();
        };
        $scope.selectTextMatches = function(items) {
            var item;
            if (fullTextRegexTokens.length > 0) {
                $scope.toggleItems((function() {
                    var len5, r, results;
                    results = [];
                    for (r = 0, len5 = items.length; r < len5; r++) {
                        item = items[r];
                        if ($scope.checkSearchTextMatch(item) === true) {
                            results.push(item);
                        }
                    }
                    return results;
                })(), true);
            } else {
                $scope.toggleItems(items, true);
            }
        };
        $scope.selectTextMatchesChildren = function(object) {
            var setChildren;
            setChildren = function(input, setvalue) {
                var item, k, len5, r, v;
                if ($.isArray(input)) {
                    for (r = 0, len5 = input.length; r < len5; r++) {
                        item = input[r];
                        setChildren(item, setvalue);
                    }
                } else if ($.isPlainObject(input)) {
                    if ($scope.checkSearchTextMatch(input)) {
                        input.selected = setvalue;
                        $scope.setChildren(input, setvalue);
                        return;
                    }
                    for (k in input) {
                        v = input[k];
                        if ($.isArray(v)) {
                            setChildren(v, setvalue);
                        }
                    }
                }
            };
            return setChildren(object, true);
        };
        $scope.toggleChildren = function(object) {
            var newState, startState;
            startState = object.selected != null ? object.selected : false;
            newState = this.newState != null ? this.newState : !startState;
            object.selected = newState;
            return $scope.setChildren(object, newState);
        };
        $scope.setChildren = function(object, value) {
            var setChildren;
            setChildren = function(input, value) {
                var item, k, len5, r, v;
                if ($.isArray(input)) {
                    for (r = 0, len5 = input.length; r < len5; r++) {
                        item = input[r];
                        for (k in item) {
                            v = item[k];
                            if ($.isArray(v)) {
                                setChildren(v, value);
                            } else {
                                item.selected = value;
                            }
                        }
                    }
                } else if ($.isPlainObject(input)) {
                    for (k in input) {
                        v = input[k];
                        setChildren(v, value);
                    }
                }
            };
            setChildren(object, value);
        };
        $scope.checkSelection = function(object) {
            var checkChildren, isItALeafNode, selected;
            selected = null;
            isItALeafNode = false;
            checkChildren = function(input, value) {
                var item, k, kk, len5, r, v, vv;
                if ($.isArray(input)) {
                    for (r = 0, len5 = input.length; r < len5; r++) {
                        item = input[r];
                        for (k in item) {
                            v = item[k];
                            if ($.isArray(v)) {
                                checkChildren(v, value);
                            } else {
                                if (true !== (function() {
                                        var results;
                                        results = [];
                                        for (kk in v) {
                                            vv = v[kk];
                                            results.push($.isArray(vv));
                                        }
                                        return results;
                                    })()) {
                                    isItALeafNode = true;
                                }
                                if (selected === null) {
                                    selected = item.selected != null ? item.selected : false;
                                } else if (item.selected === selected) {
                                    selected = item.selected;
                                } else {
                                    selected = -1;
                                }
                            }
                        }
                    }
                } else if ($.isPlainObject(input)) {
                    for (k in input) {
                        v = input[k];
                        checkChildren(v, value);
                    }
                }
            };
            checkChildren(object);
            return isItALeafNode;
        };
        $scope.getFriendlyQueryname = function(object) {
            var len5, name, r;
            name = "";
            for (r = 0, len5 = datasets.length; r < len5; r++) {
                dataset = datasets[r];
                if (dataset.selected === true) {
                    name += dataset.name + " ";
                }
            }
            return name;
        };
        $scope.initializeData = function() {
            $scope.getLevels($scope.tree);
            $scope.propagateAttributes($scope.tree);
            return $scope.view.filters = $scope.getAllFilters($scope.tree);
        };
        $http.get('metadata')
            .success(function(data, status, headers, config) {
                $scope.tree = data.experiments;
                $scope.initializeData();
                console.log("using live data");
                console.log(data);
            })
            .error(function(data, status, headers, config) {
                console.log('Could not query metadata due to ' + status + ', using cached data.');
                $scope.tree = root.tree;
                $scope.initializeData();
            });
        }
    ]);

}).call(this);
