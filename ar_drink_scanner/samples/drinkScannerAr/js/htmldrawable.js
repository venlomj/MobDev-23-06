var World = {

    init: function initFn() {
        this.createOverlays();
    },

    createOverlays: function createOverlaysFn() {
        /*
            First a AR.TargetCollectionResource is created with the path to the Wikitude Target Collection(.wtc) file.
            This .wtc file can be created from images using the Wikitude Studio. More information on how to create them
            can be found in the documentation in the TargetManagement section.
            Each target in the target collection is identified by its target name. By using this
            target name, it is possible to create an AR.ImageTrackable for every target in the target collection.
         */
        this.targetCollectionResource = new AR.TargetCollectionResource("assets/tracker.wtc", {
            onError: World.onError
        });

        /*
            This resource is then used as parameter to create an AR.ImageTracker. Optional parameters are passed as
            object in the last argument. In this case a callback function for the onTargetsLoaded trigger is set. Once
            the tracker loaded all of its target images this callback function is invoked. We also set the callback
            function for the onError trigger which provides a sting containing a description of the error.
         */
        this.tracker = new AR.ImageTracker(this.targetCollectionResource, {
            onTargetsLoaded: World.showInfoBar,
            onError: World.onError
        });

        /*

        The code below creates the image overlays to generate on each of the 4 beverages that are coded into the application

        */

        var colaImg = new AR.ImageResource("assets/cola/cola.png", {
            onError: World.onError
        });
        var colaOverlay = new AR.ImageDrawable(colaImg, 0.5, {
            translate: {
                x: 0.9
            }
        });

        var pepsiImg = new AR.ImageResource("assets/pepsi/pepsi.png", {
            onError: World.onError
        });
        var pepsiOverlay = new AR.ImageDrawable(pepsiImg, 0.5, {
            translate: {
                x: 0.9
            }
        });

        var spriteImg = new AR.ImageResource("assets/sprite/sprite.png", {
            onError: World.onError
        });
        var spriteOverlay = new AR.ImageDrawable(spriteImg, 0.5, {
            translate: {
                x: 0.7
            }
        });

        var fantaImg = new AR.ImageResource("assets/fanta/fanta.png", {
            onError: World.onError
        });
        var fantaOverlay = new AR.ImageDrawable(fantaImg, 0.5, {
            translate: {
                x: 0.9
            }
        });


        /*

        For each drink prepared in our WTC wikitude file we create 2 seperate HTMLDrawables to overlay onto the drink

        The first of these widgets, simply called (drinkname)Widget, is loaded from the prepared HTML and access the API to retrieve the name and sugar content

        The second widget, titled (drinkname)RatingWidget, is loaded from its prepared HTML, which retrieves the active rating from the api, and then also allows
        the user to input their own rating which is sent directly to our API and updated 

        */

        var colaWidget = new AR.HtmlDrawable({
            uri: "assets/cola/cola.html"
        }, 0.75, {
            viewportWidth: 1000,
            viewportHeight: 500,
            backgroundColor: "#FFFFFF",
            translate: {
                x: 0.3,
                y: 0.7
            },
            horizontalAnchor: AR.CONST.HORIZONTAL_ANCHOR.RIGHT,
            verticalAnchor: AR.CONST.VERTICAL_ANCHOR.TOP,
            clickThroughEnabled: true,
            allowDocumentLocationChanges: false,
            onDocumentLocationChanged: function onDocumentLocationChangedFn(uri) {
                AR.context.openInBrowser(uri);
            },
            onError: World.onError
        });

        var colaRatingWidget = new AR.HtmlDrawable({
            uri: "assets/cola/colaRating.html"
        }, 0.75, {
            viewportWidth: 1000,
            viewportHeight: 500,
            backgroundColor: "#FFFFFF",
            translate: {
                x: 0.3,
                y: -0.5
            },
            horizontalAnchor: AR.CONST.HORIZONTAL_ANCHOR.RIGHT,
            verticalAnchor: AR.CONST.VERTICAL_ANCHOR.TOP,
            clickThroughEnabled: true,
            allowDocumentLocationChanges: false,
            onDocumentLocationChanged: function onDocumentLocationChangedFn(uri) {
                AR.context.openInBrowser(uri);
            },
            onError: World.onError
        });

        var pepsiWidget = new AR.HtmlDrawable({
            uri: "assets/pepsi/pepsi.html"
        }, 0.75, {
            viewportWidth: 1000,
            viewportHeight: 500,
            backgroundColor: "#FFFFFF",
            translate: {
                x: 0.3,
                y: 0.7
            },
            horizontalAnchor: AR.CONST.HORIZONTAL_ANCHOR.RIGHT,
            verticalAnchor: AR.CONST.VERTICAL_ANCHOR.TOP,
            clickThroughEnabled: true,
            allowDocumentLocationChanges: false,
            onDocumentLocationChanged: function onDocumentLocationChangedFn(uri) {
                AR.context.openInBrowser(uri);
            },
            onError: World.onError
        });

        var pepsiRatingWidget = new AR.HtmlDrawable({
            uri: "assets/pepsi/pepsiRating.html"
        }, 0.75, {
            viewportWidth: 1000,
            viewportHeight: 500,
            backgroundColor: "#FFFFFF",
            translate: {
                x: 0.3,
                y: -0.5
            },
            horizontalAnchor: AR.CONST.HORIZONTAL_ANCHOR.RIGHT,
            verticalAnchor: AR.CONST.VERTICAL_ANCHOR.TOP,
            clickThroughEnabled: true,
            allowDocumentLocationChanges: false,
            onDocumentLocationChanged: function onDocumentLocationChangedFn(uri) {
                AR.context.openInBrowser(uri);
            },
            onError: World.onError
        });

        var spriteWidget = new AR.HtmlDrawable({
            uri: "assets/sprite/sprite.html"
        }, 0.75, {
            viewportWidth: 1000,
            viewportHeight: 500,
            backgroundColor: "#FFFFFF",
            translate: {
                x: 0.3,
                y: 0.7
            },
            horizontalAnchor: AR.CONST.HORIZONTAL_ANCHOR.RIGHT,
            verticalAnchor: AR.CONST.VERTICAL_ANCHOR.TOP,
            clickThroughEnabled: true,
            allowDocumentLocationChanges: false,
            onDocumentLocationChanged: function onDocumentLocationChangedFn(uri) {
                AR.context.openInBrowser(uri);
            },
            onError: World.onError
        });

        var spriteRatingWidget = new AR.HtmlDrawable({
            uri: "assets/sprite/spriteRating.html"
        }, 0.75, {
            viewportWidth: 1000,
            viewportHeight: 500,
            backgroundColor: "#FFFFFF",
            translate: {
                x: 0.3,
                y: -0.5
            },
            horizontalAnchor: AR.CONST.HORIZONTAL_ANCHOR.RIGHT,
            verticalAnchor: AR.CONST.VERTICAL_ANCHOR.TOP,
            clickThroughEnabled: true,
            allowDocumentLocationChanges: false,
            onDocumentLocationChanged: function onDocumentLocationChangedFn(uri) {
                AR.context.openInBrowser(uri);
            },
            onError: World.onError
        });

        var fantaWidget = new AR.HtmlDrawable({
            uri: "assets/fanta/fanta.html"
        }, 0.75, {
            viewportWidth: 1000,
            viewportHeight: 500,
            backgroundColor: "#FFFFFF",
            translate: {
                x: 0.3,
                y: 0.7
            },
            horizontalAnchor: AR.CONST.HORIZONTAL_ANCHOR.RIGHT,
            verticalAnchor: AR.CONST.VERTICAL_ANCHOR.TOP,
            clickThroughEnabled: true,
            allowDocumentLocationChanges: false,
            onDocumentLocationChanged: function onDocumentLocationChangedFn(uri) {
                AR.context.openInBrowser(uri);
            },
            onError: World.onError
        });

        var fantaRatingWidget = new AR.HtmlDrawable({
            uri: "assets/fanta/fantaRating.html"
        }, 0.75, {
            viewportWidth: 1000,
            viewportHeight: 500,
            backgroundColor: "#FFFFFF",
            translate: {
                x: 0.3,
                y: -0.5
            },
            horizontalAnchor: AR.CONST.HORIZONTAL_ANCHOR.RIGHT,
            verticalAnchor: AR.CONST.VERTICAL_ANCHOR.TOP,
            clickThroughEnabled: true,
            allowDocumentLocationChanges: false,
            onDocumentLocationChanged: function onDocumentLocationChangedFn(uri) {
                AR.context.openInBrowser(uri);
            },
            onError: World.onError
        });

        /*
            This combines everything by creating an AR.ImageTrackable with the previously created tracker,
            the name of the image target and the drawable that should augment the recognized image.

        */
        this.cola = new AR.ImageTrackable(this.tracker, "cola", {
            drawables: {
                cam: [colaWidget, colaRatingWidget, colaOverlay]
            },
            onImageRecognized: World.hideInfoBar,
            onError: World.onError
        });

        this.pepsi = new AR.ImageTrackable(this.tracker, "pepsi", {
            drawables: {
                cam: [pepsiWidget, pepsiRatingWidget, pepsiOverlay]
            },
            onImageRecognized: World.hideInfoBar,
            onError: World.onError
        });
        this.sprite = new AR.ImageTrackable(this.tracker, "sprite", {
            drawables: {
                cam: [spriteWidget, spriteRatingWidget, spriteOverlay]
            },
            onImageRecognized: World.hideInfoBar,
            onError: World.onError
        });
        this.fanta = new AR.ImageTrackable(this.tracker, "fanta", {
            drawables: {
                cam: [fantaWidget, fantaRatingWidget, fantaOverlay]
            },
            onImageRecognized: World.hideInfoBar,
            onError: World.onError
        });
    },

    onError: function onErrorFn(error) {
        alert(error);
    },
};

World.init();