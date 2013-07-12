/*
 * Copyright (C) 2012-2013 Canonical, Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import QtContacts 5.0
import Ubuntu.Components 0.1

MainView {
    id: mainView

    width: units.gu(40)
    height: units.gu(71)

    PageStack {
        id: mainStack

        anchors {
            fill: parent
            Behavior on bottomMargin {
                NumberAnimation {
                    duration: 175
                    easing.type: Easing.OutQuad
                }
            }

            // make the page full visible if the inputMethod appears
            bottomMargin: Qt.inputMethod.visible ? toolbar.height + Qt.inputMethod.keyboardRectangle.height + units.gu(2) : 0
            //TODO: waiting for final design to correct implementation
            onBottomMarginChanged: console.debug("TODO: implement scroll to correct position")
        }
    }

    // Make the toolbar visible if it is locked and the inputMethod appears
    Binding {
        target: toolbar
        property: "anchors.bottomMargin"
        value: Qt.inputMethod.visible && toolbar.locked ? Qt.inputMethod.keyboardRectangle.height : 0
        when: toolbar
    }

    Component.onCompleted: {
        mainStack.push(Qt.createComponent("ContactList/ContactList.qml"))
    }
}
