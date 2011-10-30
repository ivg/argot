(*
 * This file is part of Argot.
 * Copyright (C) 2010-2011 Xavier Clerc.
 *
 * Argot is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * Argot is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *)

let attention_base64 = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAJPSURBVDjLpZPLS5RhFMYfv9QJlelTQZwRb2OKlKuINuHGLlBEBEOLxAu46oL0F0QQFdWizUCrWnjBaDHgThCMoiKkhUONTqmjmDp2GZ0UnWbmfc/ztrC+GbM2dXbv4ZzfeQ7vefKMMfifyP89IbevNNCYdkN2kawkCZKfSPZTOGTf6Y/m1uflKlC3LvsNTWArr9BT2LAf+W73dn5jHclIBFZyfYWU3or7T4K7AJmbl/yG7EtX1BQXNTVCYgtgbAEAYHlqYHlrsTEVQWr63RZFuqsfDAcdQPrGRR/JF5nKGm9xUxMyr0YBAEXXHgIANq/3ADQobD2J9fAkNiMTMSFb9z8ambMAQER3JC1XttkYGGZXoyZEGyTHRuBuPgBTUu7VSnUAgAUAWutOV2MjZGkehgYUA6O5A0AlkAyRnotiX3MLlFKduYCqAtuGXpyH0XQmOj+TIURt51OzURTYZdBKV2UBSsOIcRp/TVTT4ewK6idECAihtUKOArWcjq/B8tQ6UkUR31+OYXP4sTOdisivrkMyHodWejlXwcC38Fvs8dY5xaIId89VlJy7ACpCNCFCuOp8+BJ6A631gANQSg1mVmOxxGQYRW2nHMha4B5WA3chsv22T5/B13AIicWZmNZ6cMchTXUe81Okzz54pLi0uQWp+TmkZqMwxsBV74Or3od4OISPr0e3SHa3PX0f3HXKofNH/UIG9pZ5PeUth+CyS2EMkEqs4fPEOBJLsyske48/+xD8oxcAYPzs4QaS7RR2kbLTTOTQieczfzfTv8QPldGvTGoF6/8AAAAASUVORK5CYII="

let bug_base64 = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAKYSURBVDjLnZPJT1NRFMb5G1wDHV5boNiqdHrvFYolCAtsGSSWKpMFKhYqlDI6oAEKaVJwCIgSphaKtLYWCgSNBgRjMNHoxsSFS3cmJmA0NMTw+R6JKKZl4eJL7sm953fOd3JPHIC4WMpcppG5SGnZc8ZjVVF6QLn975sDgfaZmvg71oRJZIRUYcuAnq/2KWroGfm3QwEn2YpLVPPvOD2oiqj9yq/mGznegl56mx6T7ZbY1M6YAM0CuZkxT0b2Wg6QW/SsApRXDsotR+d6E9Y/h9DuqoCuJq0lKoDxqU1/pITGR27mBU4h+GEcTz5OY+ClA5JbyahYzof/9TBO9B/FcWcqpA4xU3We3GJ87ntnfO5meinMvruNnqcmXA2XoDVcCc0wCYkzBaZpA7ILRJ/2O2B87jA+QT9UeDRe8svZYAG8b/txc6kc9mA+yqayYPQXwvdmBEOrA5B2p0BtFIYOWKCm5RukWwZyXIbA+0F0LpaiKaBHmVsLw4we99ccsM8a8GClF5JOMcQdou8prULrgRmQo7KI0VcE13MrGv06lE5kodhzGvdWu2GdKkTVWC4DcELcJkKyXbCb1EhAVM//M0DVUNqP2qAJd1baUDaZjTMTeXAttsPi0cM0mgvHvA0NkxYk2QRIrieOsDmEmXttH0DfVfSluSToWmpD8bgOroUOWNw6VI7koGfOBuq6EqLLTNU6ojrmP5D1HVsjmrkYezGIrlA9LjKgnrlGXJlpgbCOD0EtD0QNN8I3cZqjAlhJr4rXpB1iNLhrYffUQWoT7yUKzbxqJlHLq0jc5JYmgHMunogKYJVqF7mTrPyfgktMRTMX/CrOq1gLF3fYNrLiX+Bs8MoTwT2fQPwXgBXHGL+TaIjfinb3C7cscRMIcYL6AAAAAElFTkSuQmCC"

let error_base64 = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAHdSURBVDjLpZNraxpBFIb3a0ggISmmNISWXmOboKihxpgUNGWNSpvaS6RpKL3Ry//Mh1wgf6PElaCyzq67O09nVjdVlJbSDy8Lw77PmfecMwZg/I/GDw3DCo8HCkZl/RlgGA0e3Yfv7+DbAfLrW+SXOvLTG+SHV/gPbuMZRnsyIDL/OASziMxkkKkUQTJJsLaGn8/iHz6nd+8mQv87Ahg2H9Th/BxZqxEkEgSrq/iVCvLsDK9awtvfxb2zjD2ARID+lVVlbabTgWYTv1rFL5fBUtHbbeTJCb3EQ3ovCnRC6xAgzJtOE+ztheYIEkqbFaS3vY2zuIj77AmtYYDusPy8/zuvunJkDKXM7tYWTiyGWFjAqeQnAD6+7ueNx/FLpRGAru7mcoj5ebqzszil7DggeF/DX1nBN82rzPqrzbRayIsLhJqMPT2N83Sdy2GApwFqRN7jFPL0tF+10cDd3MTZ2AjNUkGCoyO6y9cRxfQowFUbpufr1ct4ZoHg+Dg067zduTmEbq4yi/UkYidDe+kaTcP4ObJIajksPd/eyx3c+N2rvPbMDPbUFPZSLKzcGjKPrbJaDsu+dQO3msfZzeGY2TCvKGYQhdSYeeJjUt21dIcjXQ7U7Kv599f4j/oF55W4g/2e3b8AAAAASUVORK5CYII="

let info_base64 = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAKcSURBVDjLpZPLa9RXHMU/d0ysZEwmMQqZiTaP0agoaKGJUiwIxU0hUjtUQaIuXHSVbRVc+R8ICj5WvrCldJquhVqalIbOohuZxjDVxDSP0RgzyST9zdzvvffrQkh8tBs9yy9fPhw45xhV5X1U8+Yhc3U0LcEdVxdOVq20OA0ooQjhpnfhzuDZTx6++m9edfDFlZGMtXKxI6HJnrZGGtauAWAhcgwVnnB/enkGo/25859l3wIcvpzP2EhuHNpWF9/dWs/UnKW4EOGDkqhbQyqxjsKzMgM/P1ymhlO5C4ezK4DeS/c7RdzQoa3x1PaWenJjJZwT9rQ1gSp/js1jYoZdyfX8M1/mp7uFaTR8mrt29FEMQILr62jQ1I5kA8OF59jIItVA78dJertTiBNs1ZKfLNG+MUHX1oaURtIHEAOw3p/Y197MWHEJEUGCxwfHj8MTZIcnsGKxzrIURYzPLnJgbxvG2hMrKdjItjbV11CYKeG8R7ygIdB3sBMFhkem0RAAQ3Fuka7UZtRHrasOqhYNilOwrkrwnhCU/ON5/q04vHV48ThxOCuoAbxnBQB+am65QnO8FqMxNCjBe14mpHhxBBGCWBLxD3iyWMaYMLUKsO7WYH6Stk1xCAGccmR/Ozs/bKJuXS39R/YgIjgROloSDA39Deit1SZWotsjD8pfp5ONqZ6uTfyWn+T7X0f59t5fqDhUA4ry0fYtjJcWeZQvTBu4/VqRuk9/l9Fy5cbnX+6Od26s58HjWWaflwkusKGxjm1bmhkvLXHvh1+WMbWncgPfZN+qcvex6xnUXkzvSiYP7EvTvH4toDxdqDD4+ygT+cKMMbH+3MCZ7H9uAaDnqytpVX8cDScJlRY0YIwpAjcNcuePgXP/P6Z30QuoP4J7WbYhuQAAAABJRU5ErkJggg=="

let new_base64 = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAEMSURBVDjL3ZLBSgJRFIYvtO0BfIPeI3qBNj2Cy1rWzlWbkcBNYhC0TletJKOFq1lIILhQJCywaDZOkINiGl/n3DNj6LaF4MDHGebc/5tz544D3H9w2yAI3LkQp7UgREJRSIS+0BJqwr6QTzkWulqdD09juD3Ah5PI7r8TiPvw0YJeDUq7cJ83NDzqwmUOFUyYT/ASfasGm6d4kQo1OB3JszN4fTDujuBrqP2hW4baVxbMBIuZTfAeQucGxm/w+WzB6AleGipo/Am06hTrEwQupLhjwkFdtlOFnzlc72n/cFWgQb3WJ8i22a7A44mtCfQQ7BSyL6617BtWZ+kphMKFlwSusrJmW/7ETQt+AQhq/TxibW0lAAAAAElFTkSuQmCC"

let note_base64 = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAGGSURBVDjLxZO/alRBFMZ/c6MmomKhBLv4AIJiYekjCFopKSzyCnkGW99BbMTOQhsrBcFKsLCJhRYBNYYsWXNn5s6Z81nMGu+626XwFDOHge/PmfkmSOIk1XHCOvWn0ZdXsulPpAFZQbUgG5BlVDOURLWELEJJXLz3JMwTVOP0tfsLChIEmC2A4OD5g0UHebLLWQl5bAcBJAcC4i9D6FZRiUtGMMOHb9j0PXhGGtruA3hCnpBHzly+i5d+CUHNgCFPoDIDjcEJeQ8yNCxxYL/2m+U55Yh7mpFE8NhE7GiRwGsi7bzF8meoA8io6ZC1jfWm7AnVCPLld1DjPna4y/kbm4Djw1emH56h2oN6VFNzIKOOCI6DFCTKj48cvN6m9jtQC64yAjcXrjrnoBu/94VbDymTPSZvHs/A6RgsT0gZqC1M/46AJcJKx7mbW8RPL5m+e8HKpeusXbmNI1AFDHBkmZHzFpO9p3fkJSNLqEQsfgc6uhCQJRgy7qlF2ypXHynMEfy33/gbubc6XKsT2+MAAAAASUVORK5CYII="

let remark_base64 = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAEvSURBVDjLY/j//z8DJZiBagZEtO8QAuKlQPwTiP/jwbuAWAWbARtXHrz1//efv//xgS0n74MMuQ3EbHADgBweIP7z99+//x++/fv/8tO//88+/vv/5P2//w/f/ft/782//7df/f1/5xXE8OoFx0GGmCEbIJcz9QBY8gVQ47MP//4/Bmp+8Pbf/7tQzddf/P1/9RnEgM5VZ0EGeGM14ClQ86N3UM2v//2/9RKi+QpQ88UnuA2AewHk/PtAW++8/vv/JlDzted//18Gar7wBGTAH7ABtYtOgAywxBqIIEOQAcg1Fx7/BRuMFoicuKLxDyzK5u64Cjfo/ecfYD5Q/DLWaMSGgQrvPH/3FabxOxDXEp0SgYp7Z267AtL4BYgLSUrKQA1KQHwPiFPolxcGzAAA94sPIr7iagsAAAAASUVORK5CYII="

let stateful_base64 = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAI8SURBVDjLpVNNiFJRFP70ac80w6FEJ2FqsDKmSRpmU6taBRGE4aaCYPatat1qtu3aRosJI4Ro0Q+EIP0QCTM4WhSBBqmkJJr2cvx53vfu69w3vXIapUUPPs69553zne+ee67NMAz8z+cY3aTTaZkIzxMucc6PkD1EoCV/T/YT2TuEdCwW060cm6WAkudofd/v90eDwSA8Hg/cbjfEf0VR0Ol0UKlU0Gg0XpPvYjwer5qJIkAglUo9L5fLopwx6WOMGblczkgmkytWnt2SQpujgUDgn2cOhUKgIme39YCcJmO9XofL5YIsy3A6naav1+uh1WqhWq0iHA6bsRMJHA4H2u02BoOBudc0DUzJw8PygHTG9I0lsM4kSZKpQBAJMHUDanMNe2ZOQS3lKXkeuv77Ev70wFJgVmTMhAjUGi8xte8Edk8vwNl9C32jtEXBNgIziUhMdGsYfn0B714f9B+PMH3sCvrlJ+A6m0xgVdc0BvXLM/gjF4DBOlbv3sMuXx+DWhZevSSPJRCwquvKR8i2IbxTPXD1MzWJk/w1zJ6+jiBb96zeOundQiCki6uiSYS8QwKvPIVv5jh47x3l9rEYj4APa9TgAg5Ez0maOrz2t4KlTCbTLRaLcH7PUuOicHubMLRvNPASsg8LIgp8UID/8H7oKrv6anl+zjb6GhOJxCwR3TiorCwtXL5tl+wlImiLSx6ZRTuknRHUP+RReLz8wDbuOb+5udg0dO6mY9sN0Vyu801Ls/LLYrPp2Z9W3anPTwD1kQAAAABJRU5ErkJggg=="

let threadsafe_base64 = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAALcSURBVDjLjZJpSNNxHMb/VhTUi3pjVFoyj+wyPDG1sDUTE7ES1zCPuXRbZjZrSk63qVPzKNuc+ncmHmPOeU3nkYkEmnjhlVdaBPoiddGbMDEoj6clZEYlvnhe/fh8+P4eHgIAsVWE/kdY4wVWC7NqE0yXUZZLeebFvs7mu3+9bwnzvE1pMyrK6lzFYWxOYaSFbFuCYqaxfK7OEfOtbHzty8a81g1zmqOYKLD4vC0B6b8/Wz/SioVuEssjSiz2kJh93YL2FLuZbQn8vG9wJssfrH0ZrcXqVB2WJnTQd8ghCbmo/aeAQ7Vi5bMuLciDqSBDacsRDJtB+cPI73otHx8akqFvFKFLcRdn2adbnGLP7PtDwHSzpOWzPFZlgVRsTomUh9zCVGTmiZD4JBYNb8qR1i6Bjdi6zJZ/fO+GQMqw73oWcQ11SWGYrBBCzadDHkyDguuB0hEhotSuYJfaIX0gGjVvixGti4JLhBO5IchjWNS8b9f8VZgmngrpcBzClY5IbroJhuIE4nq5YJGhmCZ9/18YT30B91TnwFU6gFVsC2E9HdUDOYipuYrL0kMIkDIwX+TzW7DDIUeQJ4jaKCxS5QzdMAntUN46WDkgg+xlDJS9Wbit9oRT+p61riIf9jps5FYZ7scfWuz4CDyq1kJUokGY4b8/4adtPGS2RiKthYOkJhYkz7lQdKYgqOw8rBKJFYLiraDTec1LjVOrSJ0E2P1ASAcQWHQSVf0yqA0LVPZkoaQ7wyC5g4JOCThqL1BExCcTAWFLjKU6rgzW5oJfrwezFWDq1hCoWcP1AnNcyTEFTXoQbo8PIKTUFeSrJNxSecJMROgPC4hT6zuYyXGfr027jwBxHzhtAOuF4QIdENwIBDUDjIxpiPnpsE/dBaaSBrMEYtYAW28s8Z2K69Ii8Yt3ppfrHKMHQBWPGTIOqnAU7vFDsPCqmsmNCU+yFBt9O5awE8YCgrJ5vT8AXgaV02he+4MAAAAASUVORK5CYII="

let threadunsafe_base64 = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAALcSURBVDjLjZFpMNRxGMfVi17UNL3qRdcLRI2jiUgyHdp6ozIlco3Whm1c49gwmyNndGBtLB3uRdPuCrOtnWoPokGMs5WwMth1S9q/Y+PbzjaJqTFefOb34jffzzPP99EBoLMRUY57KZ3ZBrPDJfsgL9BV5wfp5dpb6W37879hOMhuP2mgWHd5pHQP1vLEX5+xKUEueTdzpNwCCqEPiIZUKHg2GCk7gK5s/ZlNCViOu1KVbULM1rOgbivE3AcWhlsFkCSYDWxK4GB3nSpjh658b+diubscqq4KKKVMxN84y/uvgGprQMminJtletiC5UlS+zqbNjMj/JeUPBqGKuOgrIpGXU4AjvgYCyzDTHasE5BtDpKyKOeXGe62WEteehC4pRFo5nshmUFD5Sc2kiTxMI05VHCUZrh9VZDubF731PcKymO9ICuNQgnNCUwPEp4HXECnmIypXg6E0ptIaQkF53MugisCYe1ryVoVZDrrc3olZf8UVpNzERPdbKh/9KGj8hrS6r1Bb/QDheUJOct+48JGxClo517FwgQfC4o0TPe/hqTKGeF8P7ilu0Hx7NJfwdZjGfRMeuC6wlrZLpjs4WJhKB61KcewNMVFax4JIY9OjYVRY2Pl+a7u2vAWmxfeDrSWOekocO8lD9F5ZWDkJGNAFInF8SIQfRTUJpthfjAC3+QCNGWelDVmnNipvYKuXY6TUxBfVdW9jEQZ4NMEUCRqVBf5YkZT3PzX21B9cflNr4dmFQYGa5iof2AeoxV0JFr8bOY+Bu2VEmQhQK5YwcPCcgzWpmFxNFs7XdXrrlnBXPsScj8QykrUJpiO1cQZG+kMZJxRcJNC4BrTAOobzfRqQJx5GcRkPxanRVgY13QwzlkDD+q5Lgw3sCGONOTo9BTfshbEO9yxcmJXWAR/hG1MB97ePw1J8nGIkywhijNbkcaZqKV3jRYl0YcJTYgQ0Q0IUYQ+8S5c7/0vfNrCXhlwpm0AAAAASUVORK5CYII="

let todo_base64 = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAKwSURBVDjLbVPPaxNBGH27m5jdaH5ZjU3SFkRiWkwt0l4qFupFEY/Bg/jj6MGLIPQigtCDf4BXLYZKK6UJSL2Ih4AGLGltTSUh1pgaJBXTEkNMY9NNdtf5Rlva2IFvv9mZN9978z5GMAwDrSMejz+sVCo3y+Wyl/5dLtd3h8MxPjQ0dO8/MBXYHdFo1D01NaUaLYPWJicnva14gT7/GK8yxi5WU2Rs8Pv9CAQCHJTJZLCysgKGIU6dKfrGMM+5IgKw6vXdbPl83ohEIsbS0hKP6elpvtaiiM5A6uvreypJ0gD9tLW18YLLy8toNptgh1AsFmG326FpGjweD3RdRzqdJjWm2dnZgIktXA8Gg6jVamBsYMWwurqKUCi0xyvmDaxWKxqNBsc6nU6USqUrImOs+Xw+dHR0gO5us9ngdruRzWY5G0Xu4wyCh9/BYmqA+QRVVakzpLZm2m6jLMswm82oVqs8k2GpVIq5rEIuvcbRrmHkc69gls/t6Z64XYAysSmKgs7OTq7GYrFAK8Xh8g7C7jkDpZ6CRV/nePKEF2ATRRRFUND9SB5lQRCg13/gQHUetiNOaL9m0N57A+byG+hak5OxszIpeJtIJLhkMolMpE3DYLEWw7EeZmZ9EXPjEzjk3IRU+QTLZha5XI4UJEQGvlwoFG7FYrEvyWSSM1PbhI0srJIGm+s39K2v7I6McWMex4fvQsu/aGz8LIywApeEbQ/C4bCbze+wuN0d8DudxWfwnr4A2ZyArhb+9lIwQzrYj2JWRCERfnB2ZGFUaH1MY2Njpzz6h3Cw+8RA+0mFsc4xqSoWohn0h3ogSA5AuYj3T+6vGbp+XtjvNc49Giz0XpvwSWIeRrNMPdq1K0JSAiimk/j8cjRiwj6juaXKi49Dm4bOek2G7oSxk8GNNtr/AJE93CiYMK0yAAAAAElFTkSuQmCC"

let todoc_base64 = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAIBSURBVDjLlZPNTxNBGIeLV/8FNUYisaIRqOHswat3DfHgzXhUIwQIQWKUgyFq2pgm6oHgxcKBiJ76YRcS8CJJNVFoqZSaXbof3e3H7s52qz9nRoZIkRQneTKT7LzPvL/JTgBAgI5jlBClvw0nKUdYjSCwIwgRQizf9382m038C/od4XD4aatECPpZcb1eh23bu1QqFZimiVKpxCWKoiASieyRsNHBBGyD67rwPI/PjFqtBsuyoKoqFziOA3ZINBrlkn0CVixgAlZQrVahadq+SDt30rFHQGPsbmBrlltE0XWddyLL8sGCVoSkXFzE1sooDG0LhmEcXsBjuVUUlu7AyMYgZ17ySP8l0NfeQPs6A7+ew9rbAZjK58MLHGsT6wvXQbQFEHkK5Y13yKfG4DdIe4HfaKC4/Jh2MAtSnIA0GULDmMXqq8swcqn2Aqv4Ed8TI/DUaTi5G5Ae9cItDMLKv0fm9TUETxy9dKCAtfht/iZMenHu5l3Y61f/kKVx5CcopJ9h+nYw2ir4JQTbmTkUpCl428/56XZ2gEbo47OTvwVHmUdy/Fw5fb/7rHgLF+nfZ9Ni/pg+vbgCR9+AV06AqPQO1NhfzMGvfcGPlRkkR7piQnCcScSzlSZ7LelhD0k/uEA+TJwnqfFukhwLkuToGZIY7iLxodMkPtjpxu+dWvwNhj+uekyCXgUAAAAASUVORK5CYII="

let tofix_base64 = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAALbSURBVDjLfZHrM5RhGMb9A33uq7ERq7XsOry7y2qlPqRFDsVk0c4wZZgRckjJeWMQRhkju5HN6V1nERa7atJMw0zMNLUow1SOUby7mNmrdzWJWn245nnumee+7vt3PRYALI6SZy8fnt08kenu0eoW4E666v9+c6gQDQgYB2thJwGPNrfOmBJfK0GTSxT/qfP3/xqcNk3s4SX9rt1VbgZBs+tq9N1zSv98vp5fwzWG3BAUHGkg7CLWPToIw97KJLHBb3QBT+kMXq0zMrQJ0M63IbUoAuIozk2zBjSnyL3FFcImYt2HPAvVlBx97+pRMpoH1n1bRPT6oXmsEk7Fp+BYYA+HPCY9tYPYoDn32WlOo6eSh8bxUuQ+lyK9MwTJnZEQVhJgFdhBWn8Z3v42uv0NaM4dmhP8Bpc6oZJYuqTyh/JNMTJ7wpGo8oPkiRfyO4IxOXId1cOFcMixgyDUuu0QAq/e+RVRywUh54KcqEBGdxgSSF9IakUIb/DD24FIrOpaoO6PBSuDCWaazaZdsnXcoQyIR1xDaFMAigbjEN8sRpjCC0F1F9A3EIdlOofdzWlMtgfDN5sN28QTxpPxDNjEWv0J0O0BZ+uaSoqyoRRIHnsjUOGDqu4ETLRehGG5G4bPJVib6YHioRDiVPvjph5GtOXtfQN+uYuMU8RCdk8KguRiFHelobVBjJX3JAzz2dDe42JnlcSE/IxxvFoUaPYbuTK2hpFkiZqRClSRUnxUp2N7qQ7U9FVoZU7Qz6VgffYZBkuJxddlxLF/DExySGdqOLfsMag4j290cPpPSdj6EPJLOgmNUoo5TTnac9mlZg1MypJxx+a0Jdj+Wrk3fUt3hUbg7J3UbAyoLx3Q5rAWNVn2TLMG9HoL1MoMttfUMCzRGSy1HJAKuz+msDBWj6F0mxazBi8LOSsvZI7UaB6boidRA5lM9GfYYfiOLUU3Ueo0a0qdwqAGk61GfwIga508Gu46TQAAAABJRU5ErkJggg=="

let transparent_base64 = "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAA1JREFUCNdjYGBgYAAAAAUAAV7zKjoAAAAASUVORK5CYII="

let warning_base64 = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAIsSURBVDjLpVNLSJQBEP7+h6uu62vLVAJDW1KQTMrINQ1vPQzq1GOpa9EppGOHLh0kCEKL7JBEhVCHihAsESyJiE4FWShGRmauu7KYiv6Pma+DGoFrBQ7MzGFmPr5vmDFIYj1mr1WYfrHPovA9VVOqbC7e/1rS9ZlrAVDYHig5WB0oPtBI0TNrUiC5yhP9jeF4X8NPcWfopoY48XT39PjjXeF0vWkZqOjd7LJYrmGasHPCCJbHwhS9/F8M4s8baid764Xi0Ilfp5voorpJfn2wwx/r3l77TwZUvR+qajXVn8PnvocYfXYH6k2ioOaCpaIdf11ivDcayyiMVudsOYqFb60gARJYHG9DbqQFmSVNjaO3K2NpAeK90ZCqtgcrjkP9aUCXp0moetDFEeRXnYCKXhm+uTW0CkBFu4JlxzZkFlbASz4CQGQVBFeEwZm8geyiMuRVntzsL3oXV+YMkvjRsydC1U+lhwZsWXgHb+oWVAEzIwvzyVlk5igsi7DymmHlHsFQR50rjl+981Jy1Fw6Gu0ObTtnU+cgs28AKgDiy+Awpj5OACBAhZ/qh2HOo6i+NeA73jUAML4/qWux8mt6NjW1w599CS9xb0mSEqQBEDAtwqALUmBaG5FV3oYPnTHMjAwetlWksyByaukxQg2wQ9FlccaK/OXA3/uAEUDp3rNIDQ1ctSk6kHh1/jRFoaL4M4snEMeD73gQx4M4PsT1IZ5AfYH68tZY7zv/ApRMY9mnuVMvAAAAAElFTkSuQmCC"

let all = [
  "attention", attention_base64;
  "bug", bug_base64;
  "error", error_base64;
  "info", info_base64;
  "new", new_base64;
  "note", note_base64;
  "remark", remark_base64;
  "stateful", stateful_base64;
  "threadsafe", threadsafe_base64;
  "threadunsafe", threadunsafe_base64;
  "todo", todo_base64;
  "todoc", todoc_base64;
  "tofix", tofix_base64;
  "warning", warning_base64;
]

let icons_source =
  "the 'Silk icon set 1.3' by Mark James, "
  ^ "available at http://www.famfamfam.com/lab/icons/silk/"

let style =
  "border: 0px; width: 24px; height: 24px; background-repeat:no-repeat;"

let css =
  ["";
   "/* Argot icons -- from " ^ icons_source ^ " */"]
  @ (List.map
       (fun (name, base64) ->
         Printf.sprintf
           ".argot_%s { %s background-image:url(data:image/png;base64,%s); }"
           style
           name
           base64)
       all)
