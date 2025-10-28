$(document).ready(function () {
  const tabContent = $(".tab-content");
  const tabLinks = $('a[data-bs-toggle="tab"]'); // Selects the navigation links
  let isAnimating = false; // Flag to prevent clicks during animation
  const animationDuration = 800; // Define duration in ms

  tabLinks.on("show.bs.tab", function (e) {
    // e.target:      the newly activated tab link
    // e.relatedTarget: the previous active tab link

    if (isAnimating) {
      e.preventDefault(); // Prevent the tab switch if animation is ongoing
      return; // Exit if already animating
    }

    isAnimating = true; // Set animation flag
    tabLinks.css('pointer-events', 'none'); // Disable clicks on tab links

    const previousTabLink = $(e.relatedTarget); // The link of the tab being left
    const currentTabLink = $(e.target);      // The link of the tab being entered

    // Find the corresponding panes using the href attribute
    const previousTabPaneId = previousTabLink.attr("href");
    const currentTabPaneId = currentTabLink.attr("href");
    const previousTabPane = $(previousTabPaneId);
    const currentTabPane = $(currentTabPaneId);

    // Get indices based on the initially cached tabLinks order
    const previousIndex = tabLinks.index(previousTabLink);
    const currentIndex = tabLinks.index(currentTabLink);

    // Ensure panes are correctly selected before proceeding
    if (!previousTabPane.length || !currentTabPane.length) {
        console.error("Could not find tab panes for animation.");
        isAnimating = false; // Reset flag on error
        tabLinks.css('pointer-events', 'auto'); // Re-enable clicks
        return;
    }

    // Reset classes before animation
    $(".tab-pane").removeClass("slide-in-left slide-in-right slide-out-left slide-out-right");

    // Determine direction
    // Check if previousIndex is valid (might be -1 on initial load)
    const isForward = previousIndex === -1 || currentIndex > previousIndex;

    // Apply animation classes
    if (isForward) {
      previousTabPane.addClass("slide-out-left");
      currentTabPane.addClass("slide-in-right");
    } else {
      previousTabPane.addClass("slide-out-right");
      currentTabPane.addClass("slide-in-left");
    }

    // Clean up classes and reset flag after animation duration
    setTimeout(function () {
      // Remove animation classes specifically, leave .active alone
      previousTabPane.removeClass("slide-out-left slide-out-right");
      currentTabPane.removeClass("slide-in-left slide-in-right");

      isAnimating = false; // Reset animation flag
      tabLinks.css('pointer-events', 'auto'); // Re-enable clicks on tab links
    }, animationDuration);
  });
});