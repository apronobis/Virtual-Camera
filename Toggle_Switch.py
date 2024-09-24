import sys
from PySide6.QtCore import QRectF, QPropertyAnimation, QEasingCurve, Qt, Property
from PySide6.QtGui import QPainter, QColor
from PySide6.QtWidgets import QWidget, QHBoxLayout, QLabel, QApplication
from PySide6.QtCore import Signal


class ToggleSwitch(QWidget):
    stateChanged = Signal(bool)  # Add this line to declare the signal

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setFixedSize(40, 20)
        self._checked = False

        self.thumb_rect = QRectF(2, 2, 16, 16)
        self._thumb_pos = 2.0

        self.animation = QPropertyAnimation(self, b"thumb_pos")
        self.animation.setDuration(10)
        self.animation.setEasingCurve(QEasingCurve.InOutQuad)

        self.setCursor(Qt.PointingHandCursor)

    def isChecked(self):
        return self._checked

    def setChecked(self, checked):
        self._checked = checked
        self.animation.setStartValue(self.thumb_pos)
        self.animation.setEndValue(22.0 if checked else 2.0)
        self.animation.start()
        self.stateChanged.emit(self._checked)  # Emit the signal when the state changes

    def mousePressEvent(self, event):
        if event.button() == Qt.LeftButton:
            self.setChecked(not self._checked)

    @Property(float)
    def thumb_pos(self):
        return self._thumb_pos

    @thumb_pos.setter
    def thumb_pos(self, pos):
        self._thumb_pos = pos
        self.update()

    def paintEvent(self, event):
        painter = QPainter(self)
        painter.setRenderHint(QPainter.Antialiasing)

        track_color = QColor(0, 150, 0) if self.isChecked() else QColor(150, 150, 150)
        painter.setBrush(track_color)
        painter.setPen(Qt.NoPen)
        painter.drawRoundedRect(0, 0, self.width(), self.height(), 10, 10)

        thumb_color = QColor(255, 255, 255)
        painter.setBrush(thumb_color)
        painter.setPen(Qt.NoPen)

        self.thumb_rect.moveLeft(self.thumb_pos)
        painter.drawEllipse(self.thumb_rect)


class LabeledToggleSwitch(QWidget):
    def __init__(self, label="Toggled_Switch", parent=None):
        super().__init__(parent)
        layout = QHBoxLayout(self)
        self.switch = ToggleSwitch(self)
        self.label = QLabel(label, self)
        self.label.setStyleSheet("color: white; font-size: 14px;")
        layout.addWidget(self.switch)
        layout.addWidget(self.label)
        layout.addStretch()
        layout.setContentsMargins(0, 0, 0, 0)


if __name__ == '__main__':
    app = QApplication(sys.argv)

    window = LabeledToggleSwitch()
    window.show()
    sys.exit(app.exec())
