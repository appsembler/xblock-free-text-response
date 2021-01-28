"""
Test utilities for the FreeTextResponse XBlock tests.
"""

from os import path, listdir
from mock import Mock

from django.conf import settings
from xblock.runtime import DictKeyValueStore, KvsFieldData
from xblock.fields import ScopeIds
from workbench.runtime import WorkbenchRuntime  # pylint: disable=all


def make_xblock(xblock_name, xblock_cls, attributes):
    """
    Helper to construct XBlock objects
    """
    runtime = WorkbenchRuntime()
    key_store = DictKeyValueStore()
    db_model = KvsFieldData(key_store)
    ids = generate_scope_ids(runtime, xblock_name)
    xblock = xblock_cls(runtime, db_model, scope_ids=ids)
    xblock.category = Mock()
    xblock.location = Mock(
        html_id=Mock(return_value='sample_element_id'),
    )
    xblock.runtime = runtime
    xblock.course_id = 'course-v1:foo+bar+baz'
    for key, value in attributes.items():
        setattr(xblock, key, value)
    return xblock


def generate_scope_ids(runtime, block_type):
    """
    Helper to generate scope IDs for an XBlock
    """
    def_id = runtime.id_generator.create_definition(block_type)
    usage_id = runtime.id_generator.create_usage(def_id)
    return ScopeIds('user', block_type, def_id, usage_id)


def get_mo_files():
    """
    Return a list of `.mo` files in this repository.
    """
    files = []
    locale_dir_path = path.join(settings.REPO_ROOT,
                                'freetextresponse/translations')

    for lang in listdir(locale_dir_path):
        mo_file_path = path.join(locale_dir_path, lang,
                                 'LC_MESSAGES', 'text.mo')

        if path.exists(mo_file_path):
            files.append(mo_file_path)

    if not files:
        raise Exception(
            'Cannot find any `.mo` file. '
            'Make sure to update the translations.'
        )

    return files
