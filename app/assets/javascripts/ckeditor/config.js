CKEDITOR.editorConfig = function (config) {
    // ... other configuration ...


    config.toolbar = [
        ['Bold', 'Italic', 'Link', 'Unlink', 'Underline', '-', 'NumberedList', 'BulletedList', '-', 'Undo', 'Redo', '-', 'SelectAll','Font','FontSize'],
        ['UIColor']
    ];

    // ... rest of the original config.js  ...
}